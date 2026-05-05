# Project 10
# Ariel
# python3
# jack syntax analyzer
# tokenizes and parses jack files into xml

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


# some characters in jack are also special in xml
# so they have to be replaced with escape codes or the xml breaks
def xmlEscape(val):
    # & first, otherwise it would doubleescape the others
    val = val.replace('&', '&amp;')
    val = val.replace('<', '&lt;')
    val = val.replace('>', '&gt;')
    val = val.replace('"', '&quot;')
    return val


# strips all comments from the jack source code
# // line and /* */ block 
def removeComments(source):
    # tried .*? is lazy so it stops at the first */ it finds
    # re.DOTALL makes . match newlines so multiline blocks work
    source = re.sub(r'/\*.*?\*/', ' ', source, flags=re.DOTALL)
    source = re.sub(r'//[^\n]*', '', source)
    return source


# breaks the source code into a list of (type, value) pairs
# uses one big regex to find all the tokens at once
def tokenize(source):
    source = removeComments(source)

    # this regex matches all 5 token types in jack
    # identifiers and keywords both match the same pattern here,
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


# writes the flat token list xml like MainT.xml
# just loops through all tokens and wraps each one in its type tag
def writeTokenXml(tokens, filepath):
    f = open(filepath, 'w')
    f.write('<tokens>\n')
    for i in range(len(tokens)):
        ttype = tokens[i][0]
        val = tokens[i][1]
        f.write('<' + ttype + '> ' + xmlEscape(val) + ' </' + ttype + '>\n')
    f.write('</tokens>\n')
    f.close()


# recursive descent parser
# walks through the token list following the jack grammar
# and writes out nested xml with proper indentation
class Parser:

    # takes the token list and opens the output file
    def __init__(self, tokens, filepath):
        self.tokens = tokens
        self.pos = 0
        self.out = open(filepath, 'w')
        # each indent level is 2 spaces
        self.indent = 0

    # close the output file when done
    def done(self):
        self.out.close()

    # shortcut to get the current token's type
    def curType(self):
        return self.tokens[self.pos][0]

    # shortcut to get the current token's value
    def curVal(self):
        return self.tokens[self.pos][1]

    # write one line to the output with the right indentation
    def write(self, text):
        self.out.write('  ' * self.indent + text + '\n')

    # write the current token as xml and move forward
    def eat(self):
        ttype = self.tokens[self.pos][0]
        val = self.tokens[self.pos][1]
        self.write('<' + ttype + '> ' + xmlEscape(val) + ' </' + ttype + '>')
        self.pos += 1

    # write an opening tag and increase indentation
    def openTag(self, tag):
        self.write('<' + tag + '>')
        self.indent += 1

    # decrease indentation and write the closing tag
    def closeTag(self, tag):
        self.indent -= 1
        self.write('</' + tag + '>')

    def compileClass(self):
        self.openTag('class')
        # eat the class
        self.eat()
        # eat the class name
        self.eat()
        # eat the {
        self.eat()
        # keep compiling class level variable declarations
        while self.curVal() == 'static' or self.curVal() == 'field':
            self.compileClassVarDec()
        # keep compiling subroutine declarations
        while self.curVal() == 'constructor' or self.curVal() == 'function' or self.curVal() == 'method':
            self.compileSubroutine()
        # eat the}
        self.eat()
        self.closeTag('class')

    def compileClassVarDec(self):
        self.openTag('classVarDec')
        # eat static or field
        self.eat()
        # eat the type like int or boolean or a class name
        self.eat()
        # eat the first variable name
        self.eat()
        # there could be more names after commas like field int x, y
        while self.curVal() == ',':
            # eat ,
            self.eat()
            # eat the next variable name
            self.eat()
        # eat the ;
        self.eat()
        self.closeTag('classVarDec')

    def compileSubroutine(self):
        self.openTag('subroutineDec')
        # eat constructor or function or method
        self.eat()
        # eat the return type
        self.eat()
        # eat the subroutine name
        self.eat()
        # eat (
        self.eat()
        # compile parameters, could be empty
        self.compileParameterList()
        # eat )
        self.eat()
        # compile the subroutine body
        self.compileSubroutineBody()
        self.closeTag('subroutineDec')

    # if empty the open and close tags still appear with nothing between
    def compileParameterList(self):
        self.openTag('parameterList')
        # if immediately see ) then the list is empty
        if self.curVal() != ')':
            # eat type
            self.eat()
            # eat varName
            self.eat()
            # more params after commas
            while self.curVal() == ',':
                # eat the ,
                self.eat()
                # eat type
                self.eat()
                # eat varName
                self.eat()
        self.closeTag('parameterList')

    def compileSubroutineBody(self):
        self.openTag('subroutineBody')
        # eat the {
        self.eat()
        # compile any local var declarations
        while self.curVal() == 'var':
            self.compileVarDec()
        # compile the statements
        self.compileStatements()
        # eat the }
        self.eat()
        self.closeTag('subroutineBody')

    def compileVarDec(self):
        self.openTag('varDec')
        # eat var
        self.eat()
        # eat the type
        self.eat()
        # eat the first var name
        self.eat()
        # could be more names like var int i, sum
        while self.curVal() == ',':
            # eat ,
            self.eat()
            # eat next var name
            self.eat()
        # eat ;
        self.eat()
        self.closeTag('varDec')

    # keeps compiling statements until it hits something else (like })
    def compileStatements(self):
        self.openTag('statements')
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
                # not a statement keyword, done
                break
        self.closeTag('statements')

    def compileLet(self):
        self.openTag('letStatement')
        # eat let
        self.eat()
        # eat the variable name
        self.eat()
        # check for array indexing like a[i]
        if self.curVal() == '[':
            # eat [
            self.eat()
            # compile the index expression
            self.compileExpression()
            # eat ]
            self.eat()
        # eat =
        self.eat()
        # compile the right hand side
        self.compileExpression()
        # eat ;
        self.eat()
        self.closeTag('letStatement')

    def compileIf(self):
        self.openTag('ifStatement')
        # eat if
        self.eat()
        # eat (
        self.eat()
        # compile the condition
        self.compileExpression()
        # eat )
        self.eat()
        # eat {
        self.eat()
        # compile the if body
        self.compileStatements()
        # eat }
        self.eat()
        # check if theres an else part
        if self.curVal() == 'else':
            # eat else
            self.eat()
            # eat {
            self.eat()
            # compile the else body
            self.compileStatements()
            # eat }
            self.eat()
        self.closeTag('ifStatement')

    def compileWhile(self):
        self.openTag('whileStatement')
        # eat while
        self.eat()
        # eat (
        self.eat()
        # compile the loop condition
        self.compileExpression()
        # eat )
        self.eat()
        # eat {
        self.eat()
        # compile the loop body
        self.compileStatements()
        # eat }
        self.eat()
        self.closeTag('whileStatement')

    # the subroutine call tokens go directly in the doStatement
    # no expression/term wrapping
    def compileDo(self):
        self.openTag('doStatement')
        # eat do
        self.eat()
        # eat the name (might be the subroutine name or a class/object name)
        self.eat()
        # if theres a dot, its something like game.run() or Screen.setColor()
        if self.curVal() == '.':
            # eat .
            self.eat()
            # eat the actual subroutine name
            self.eat()
        # eat (
        self.eat()
        # compile the argument list
        self.compileExpressionList()
        # eat )
        self.eat()
        # eat ;
        self.eat()
        self.closeTag('doStatement')

    def compileReturn(self):
        self.openTag('returnStatement')
        # eat return
        self.eat()
        # if the next thing isnt
        # then theres a return value
        if self.curVal() != ';':
            self.compileExpression()
        # eat ;
        self.eat()
        self.closeTag('returnStatement')

    def compileExpression(self):
        self.openTag('expression')
        # every expression starts with a term
        self.compileTerm()
        # then there might be op term op term... after it
        while self.curVal() in ops:
            # eat the operator
            self.eat()
            # compile the next term
            self.compileTerm()
        self.closeTag('expression')

    # a term can be a bunch of different things
    # have to look at what comes next to figure out which one it is
    def compileTerm(self):
        self.openTag('term')

        if self.curType() == 'integerConstant':
            # just a number like 42 lol
            self.eat()

        elif self.curType() == 'stringConstant':
            # just a string like "hello"
            self.eat()

        elif self.curType() == 'keyword':
            # true, false, null, or this
            self.eat()

        elif self.curVal() == '(':
            # parenthesized expression like (x + 1)
            # eat (
            self.eat()
            self.compileExpression()
            # eat )
            self.eat()

        elif self.curVal() == '-' or self.curVal() == '~':
            # unary operator like -x or ~done
            # eat the operator
            self.eat()
            # whats after a unary op is itself a term
            self.compileTerm()

        elif self.curType() == 'identifier':
            # could be just a variable, or array access, or a subroutine call
            # eat the identifier first, then check whats next to decide
            self.eat()

            if self.curVal() == '[':
                # array access like a[i]
                # eat [
                self.eat()
                self.compileExpression()
                # eat ]
                self.eat()

            elif self.curVal() == '(':
                # direct function call like draw()
                # eat (
                self.eat()
                self.compileExpressionList()
                # eat )
                self.eat()

            elif self.curVal() == '.':
                # method call like Screen.drawRectangle()
                # eat .
                self.eat()
                # eat the subroutine name
                self.eat()
                # eat (
                self.eat()
                self.compileExpressionList()
                # eat )
                self.eat()

            # if none of the above its just a plain variable name
            # already ate it so nothing else to do

        self.closeTag('term')

    # can be empty if the function takes no arguments
    def compileExpressionList(self):
        self.openTag('expressionList')
        # if ) right away the list is empty
        if self.curVal() != ')':
            self.compileExpression()
            # more expressions separated by commas
            while self.curVal() == ',':
                # eat ,
                self.eat()
                self.compileExpression()
        self.closeTag('expressionList')


# main

# get the source from command line, could be a .jack file or a folder
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
    source = f.read()
    f.close()
    tokens = tokenize(source)

    # write the token xml (like MainT.xml)
    writeTokenXml(tokens, base + 'T.xml')

    # parse and write the structured xml (like Main.xml)
    parser = Parser(tokens, base + '.xml')
    parser.compileClass()
    parser.done()

# I tested all three folders
# outputs matched compare files exactly
# only difference was CRLF vs LF line endings :))(())