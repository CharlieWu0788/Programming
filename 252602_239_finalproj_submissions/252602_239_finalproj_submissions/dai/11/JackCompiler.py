# Project 11
# Ariel
# python3
# jack compiler, compiles .jack files into .vm code

import sys
import os
import re

# all 21 keywords in jack
keywords = [
    'class', 'constructor', 'function', 'method', 'field', 'static',
    'var', 'int', 'char', 'boolean', 'void', 'true', 'false', 'null',
    'this', 'let', 'do', 'if', 'else', 'while', 'return'
]

# all the jack symbols
symbols = [
    '{', '}', '(', ')', '[', ']', '.', ',', ';',
    '+', '-', '*', '/', '&', '|', '<', '>', '=', '~'
]

# binary operators that can appear between two terms in an expression
ops = ['+', '-', '*', '/', '&', '|', '<', '>', '=']

# maps binary ops to vm commands
# * and / use Math.multiply and Math.divide instead
opCommands = {
    '+': 'add', '-': 'sub', '&': 'and', '|': 'or',
    '<': 'lt', '>': 'gt', '=': 'eq'
}

# maps variable kinds to vm memory segments
kindSegments = {
    'field': 'this', 'static': 'static',
    'arg': 'argument', 'local': 'local'
}


# strips all comments from the jack source code
# // line and /* */ block
def removeComments(source):
    # .*? is lazy so it stops at the first */ it finds
    # re.DOTALL makes . match newlines so multiline blocks work
    source = re.sub(r'/\*.*?\*/', ' ', source, flags=re.DOTALL)
    source = re.sub(r'//[^\n]*', '', source)
    return source


# breaks the source code into a list of (type value) pairs
# uses one big regex to find all the tokens at once
def tokenize(source):
    source = removeComments(source)

    # this regex matches all 5 token types in jack
    # identifiers and keywords both match the same pattern here
    # sort them out after by checking against the keyword list
    # the string part "..." has to be in the regex too so it gets captured whole
    pattern = r'[a-zA-Z_]\w*|\d+|"[^"\n]*"|[{}()\[\].,;+\-*/&|<>=~]'
    words = re.findall(pattern, source)

    # now go through each match and figure out its type
    tokens = []
    for w in words:
        if w in keywords:
            tokens.append(('keyword', w))
        elif w in symbols:
            tokens.append(('symbol', w))
        elif w[0].isdigit():
            tokens.append(('integerConstant', w))
        elif w[0] == '"':
            # strip the surrounding quotes, spec says to ignore them
            tokens.append(('stringConstant', w[1:-1]))
        else:
            tokens.append(('identifier', w))

    return tokens


# new for project 11 - wasnt needed in the syntax analyzer
# tracks variables in two scopes: class level and subroutine level
# each variable gets a name type kind and running index
class SymbolTable:

    def __init__(self):
        self.classScope = {}
        self.subScope = {}
        self.counts = {'static': 0, 'field': 0, 'arg': 0, 'local': 0}

    # called at the start of each subroutine
    # clears the subroutine scope but keeps the class scope
    def startSubroutine(self):
        self.subScope = {}
        self.counts['arg'] = 0
        self.counts['local'] = 0

    # adds a new variable to the appropriate scope
    def define(self, name, varType, kind):
        index = self.counts[kind]
        entry = (varType, kind, index)
        if kind == 'static' or kind == 'field':
            self.classScope[name] = entry
        else:
            self.subScope[name] = entry
        self.counts[kind] += 1

    # returns how many variables of the given kind have been defined
    def varCount(self, kind):
        return self.counts[kind]

    # looks up a variable by name checks subroutine scope first
    # returns the entry or None if not found
    def lookup(self, name):
        if name in self.subScope:
            return self.subScope[name]
        if name in self.classScope:
            return self.classScope[name]
        return None


# same recursive descent structure as the Parser from project 10
# but instead of writing xml tags it emits vm code
# also added symbol table and label generation
class Compiler:

    # takes the token list and opens the output file
    def __init__(self, tokens, filepath):
        self.tokens = tokens
        self.pos = 0
        self.out = open(filepath, 'w')
        self.symbols = SymbolTable()
        self.className = ''
        self.labelIndex = 0

    # close the output file when done
    def done(self):
        self.out.close()

    # shortcut to get the current tokens type
    def curType(self):
        return self.tokens[self.pos][0]

    # shortcut to get the current tokens value
    def curVal(self):
        return self.tokens[self.pos][1]

    # same as eat() from project 10 but without the xml writing
    # also returns the value now so we can capture variable names etc
    def eat(self):
        val = self.tokens[self.pos][1]
        self.pos += 1
        return val

    # write one line of vm code to the output
    def emit(self, line):
        self.out.write(line + '\n')

    # generate a unique label for if/while branching
    def newLabel(self):
        label = 'L' + str(self.labelIndex)
        self.labelIndex += 1
        return label

    # push a variable onto the stack using the symbol table
    def pushVar(self, name):
        varType, kind, index = self.symbols.lookup(name)
        self.emit('push '+kindSegments[kind]+' '+str(index))

    # pop the stack into a variable using the symbol table
    def popVar(self, name):
        varType, kind, index = self.symbols.lookup(name)
        self.emit('pop '+kindSegments[kind]+' '+str(index))

    def compileClass(self):
        # eat class
        self.eat()
        # eat the class name
        self.className = self.eat()
        # eat {
        self.eat()
        # keep compiling class level variable declarations
        while self.curVal() == 'static' or self.curVal() == 'field':
            self.compileClassVarDec()
        # keep compiling subroutine declarations
        while self.curVal() == 'constructor' or self.curVal() == 'function' or self.curVal() == 'method':
            self.compileSubroutine()
        # eat }
        self.eat()

    def compileClassVarDec(self):
        # eat static or field
        kind = self.eat()
        # eat the type like int or boolean or a class name
        varType = self.eat()
        # eat the first variable name
        name = self.eat()
        self.symbols.define(name, varType, kind)
        # there could be more names after commas like field int x y
        while self.curVal() == ',':
            self.eat()
            name = self.eat()
            self.symbols.define(name, varType, kind)
        # eat ;
        self.eat()

    def compileSubroutine(self):
        self.symbols.startSubroutine()
        # eat constructor or function or method
        subKind = self.eat()
        # eat the return type
        self.eat()
        # eat the subroutine name
        subName = self.eat()
        # eat (
        self.eat()

        # methods have an invisible first argument for this
        if subKind == 'method':
            self.symbols.define('this', self.className, 'arg')

        # compile parameters could be empty
        self.compileParameterList()
        # eat )
        self.eat()
        # eat {
        self.eat()

        # compile var declarations first to count how many locals
        while self.curVal() == 'var':
            self.compileVarDec()

        # now we know how many locals so emit the function declaration
        nLocals = self.symbols.varCount('local')
        self.emit('function '+self.className+'.'+subName+' '+str(nLocals))

        # constructor: allocate memory for the new object
        if subKind == 'constructor':
            nFields = self.symbols.varCount('field')
            self.emit('push constant '+str(nFields))
            self.emit('call Memory.alloc 1')
            self.emit('pop pointer 0')
        # method: set this to the object passed as first argument
        elif subKind == 'method':
            self.emit('push argument 0')
            self.emit('pop pointer 0')

        self.compileStatements()
        # eat }
        self.eat()

    def compileParameterList(self):
        # if immediately see ) then the list is empty
        if self.curVal() != ')':
            varType = self.eat()
            name = self.eat()
            self.symbols.define(name, varType, 'arg')
            # more params after commas
            while self.curVal() == ',':
                self.eat()
                varType = self.eat()
                name = self.eat()
                self.symbols.define(name, varType, 'arg')

    def compileVarDec(self):
        # eat var
        self.eat()
        # eat the type
        varType = self.eat()
        # eat the first var name
        name = self.eat()
        self.symbols.define(name, varType, 'local')
        # could be more names like var int i sum
        while self.curVal() == ',':
            self.eat()
            name = self.eat()
            self.symbols.define(name, varType, 'local')
        # eat ;
        self.eat()

    # keeps compiling statements until it hits something else like }
    def compileStatements(self):
        while True:
            word = self.curVal()
            if word == 'let':
                self.compileLet()
            elif word == 'if':
                self.compileIf()
            elif word == 'while':
                self.compileWhile()
            elif word == 'do':
                self.compileDo()
            elif word == 'return':
                self.compileReturn()
            else:
                # not a statement keyword done
                break

    def compileLet(self):
        # eat let
        self.eat()
        # eat the variable name
        name = self.eat()
        # check for array indexing like a[i]
        if self.curVal() == '[':
            # array assignment
            self.pushVar(name)
            self.eat()
            self.compileExpression()
            self.eat()
            self.emit('add')
            # eat =
            self.eat()
            # compile the right hand side
            self.compileExpression()
            # save value then set THAT to the address and store
            self.emit('pop temp 0')
            self.emit('pop pointer 1')
            self.emit('push temp 0')
            self.emit('pop that 0')
        else:
            # simple assignment
            self.eat()
            self.compileExpression()
            self.popVar(name)
        # eat ;
        self.eat()

    def compileIf(self):
        labelFalse = self.newLabel()
        labelEnd = self.newLabel()
        # eat if
        self.eat()
        # eat (
        self.eat()
        # compile the condition
        self.compileExpression()
        # eat )
        self.eat()
        self.emit('not')
        self.emit('if-goto '+labelFalse)
        # eat {
        self.eat()
        # compile the if body
        self.compileStatements()
        # eat }
        self.eat()
        # check if theres an else part
        if self.curVal() == 'else':
            self.emit('goto '+labelEnd)
            self.emit('label '+labelFalse)
            self.eat()
            self.eat()
            self.compileStatements()
            self.eat()
            self.emit('label '+labelEnd)
        else:
            self.emit('label '+labelFalse)

    def compileWhile(self):
        labelLoop = self.newLabel()
        labelEnd = self.newLabel()
        # eat while
        self.eat()
        self.emit('label '+labelLoop)
        # eat (
        self.eat()
        # compile the loop condition
        self.compileExpression()
        # eat )
        self.eat()
        self.emit('not')
        self.emit('if-goto '+labelEnd)
        # eat {
        self.eat()
        # compile the loop body
        self.compileStatements()
        # eat }
        self.eat()
        self.emit('goto '+labelLoop)
        self.emit('label '+labelEnd)

    def compileDo(self):
        # eat do
        self.eat()
        # eat the name
        name = self.eat()
        self.compileSubroutineCall(name)
        # discard the return value
        self.emit('pop temp 0')
        # eat ;
        self.eat()

    # handles both name(args) and name.sub(args)
    def compileSubroutineCall(self, name):
        # if theres a dot its something like game.run() or Screen.setColor()
        if self.curVal() == '.':
            self.eat()
            # eat the actual subroutine name
            subName = self.eat()
            entry = self.symbols.lookup(name)
            if entry:
                # name is a variable so this is a method call on that object
                # push the object as the hidden first argument
                varType, kind, index = entry
                self.pushVar(name)
                self.eat()
                nArgs = self.compileExpressionList()
                self.eat()
                self.emit('call '+varType+'.'+subName+' '+str(nArgs + 1))
            else:
                # name is a class name so its a function call
                self.eat()
                nArgs = self.compileExpressionList()
                self.eat()
                self.emit('call '+name+'.'+subName+' '+str(nArgs))
        else:
            # no dot means calling a method on the current object
            self.emit('push pointer 0')
            self.eat()
            nArgs = self.compileExpressionList()
            self.eat()
            self.emit('call '+self.className+'.'+name+' '+str(nArgs + 1))

    def compileReturn(self):
        # eat return
        self.eat()
        # if the next thing isnt ;
        # then theres a return value
        if self.curVal() != ';':
            self.compileExpression()
        else:
            # void functions still need to return something
            self.emit('push constant 0')
        # eat ;
        self.eat()
        self.emit('return')

    def compileExpression(self):
        # every expression starts with a term
        self.compileTerm()
        # then there might be op term op term after it
        while self.curVal() in ops:
            op = self.eat()
            self.compileTerm()
            if op == '*':
                self.emit('call Math.multiply 2')
            elif op == '/':
                self.emit('call Math.divide 2')
            else:
                self.emit(opCommands[op])

    # a term can be a bunch of different things
    # have to look at what comes next to figure out which one
    def compileTerm(self):
        if self.curType() == 'integerConstant':
            # just a number like 42 lol
            self.emit('push constant '+self.eat())

        elif self.curType() == 'stringConstant':
            val = self.eat()
            self.emit('push constant '+str(len(val)))
            self.emit('call String.new 1')
            for ch in val:
                self.emit('push constant '+str(ord(ch)))
                self.emit('call String.appendChar 2')

        elif self.curType() == 'keyword':
            # true false null or this
            kw = self.eat()
            if kw == 'true':
                self.emit('push constant 0')
                self.emit('not')
            elif kw == 'false' or kw == 'null':
                self.emit('push constant 0')
            elif kw == 'this':
                self.emit('push pointer 0')

        elif self.curVal() == '(':
            # parenthesized expression like (x + 1)
            self.eat()
            self.compileExpression()
            self.eat()

        elif self.curVal() == '-' or self.curVal() == '~':
            # unary operator like -x or ~done
            op = self.eat()
            # whats after a unary op is itself a term
            self.compileTerm()
            if op == '-':
                self.emit('neg')
            else:
                self.emit('not')

        elif self.curType() == 'identifier':
            # could be just a variable or array access or a subroutine call
            # eat the identifier first then check whats next to decide
            name = self.eat()

            if self.curVal() == '[':
                # array access like a[i]
                self.pushVar(name)
                self.eat()
                self.compileExpression()
                self.eat()
                self.emit('add')
                self.emit('pop pointer 1')
                self.emit('push that 0')

            elif self.curVal() == '(' or self.curVal() == '.':
                # subroutine call
                self.compileSubroutineCall(name)

            else:
                # just a plain variable
                self.pushVar(name)

    # can be empty if the function takes no arguments
    def compileExpressionList(self):
        count = 0
        # if ) right away the list is empty
        if self.curVal() != ')':
            self.compileExpression()
            count = 1
            # more expressions separated by commas
            while self.curVal() == ',':
                self.eat()
                self.compileExpression()
                count += 1
        return count


# main

# get the source from command line could be a .jack file or a folder
source = sys.argv[1]

# figure out which .jack files to process
if os.path.isdir(source):
    folder = source.rstrip('/')
    jackfiles = []
    for name in sorted(os.listdir(folder)):
        if name.endswith('.jack'):
            jackfiles.append(os.path.join(folder, name))
else:
    jackfiles = [source]

# process each file
for jackfile in jackfiles:
    base = os.path.splitext(jackfile)[0]

    # read and tokenize the file
    f = open(jackfile, 'r')
    src = f.read()
    f.close()
    tokens = tokenize(src)

    # compile and write the vm file
    compiler = Compiler(tokens, base + '.vm')
    compiler.compileClass()
    compiler.done()

# tested all six programs in the VM emulator all worked
# Square uses uppercase Z and X to resize not lowercase
# only difference was CRLF vs LF line endings like last time

