def ask_about_shape(shape: str) -> str:
    s = shape
    return input(f'Now, what about the {s}, where does that go? ')

if __name__ == '__main__':
    print(ask_about_shape(input()))


def is_correct(shape: str, hole: str) -> bool:
    s = shape
    h = hole
    if((s == 'cube' or s == 'rectangle') and h == 'square') or (s == 'triangle' and h == 'triangle') or (s == 'cylinder' and h == 'circle'):
        print(f"That's right, it's the {h} hole.")
        return True
    else:
        print("That's... a way to do it")
        return False

if __name__ == '__main__':
    shape=input()
    hole=input()
    print(is_correct(shape,hole))


def final_verdict(num_correct: int) -> str:
    p = num_correct
    if p == 0:
        return "......."
    elif p == 1:
        return "You only got one correct..."
    elif p == 2:
        return "That was 50/50..."
    elif p == 3:
        return "Great job!"
    elif p == 4:
        return "yyeeeaaaaassssssss!!!"

if __name__ == '__main__':
    p = int(input())
    print(final_verdict(p))


def square_hole():
    s = ['cube', 'rectangle', 'triangle', 'cylinder']
    p = 0
    for s in s:
        h = ask_about_shape(s)
        if is_correct(s, h):
            p += 1
    print(f"final verdict: {final_verdict(p)}")

if __name__ == '__main__':
    square_hole()
