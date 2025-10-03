import json
import string

# --- Configuration ---
filename = 'D:\Wu_sh\Documents\Programming\Python\aita\aita.json'

with open(filename, 'r', encoding='utf-8') as file:
    # json.load() deserializes the JSON file content into a Python dictionary
    aita_all_threads = json.load(file)
    print(f"Successfully loaded data from '{filename}'.")
    
output_filename = 'nta.json'




def contains_nta(text_passage):
    """
    Checks if a text passage contains the acronym 'NTA' (Not The Asshole),
    respecting word boundaries and ignoring case.

    Args:
        text_passage (str): The text to be analyzed, typically a post body or comment.

    Returns:
        bool: True if 'NTA' is found as a standalone word, False otherwise.
    """
    
    # 1. Normalize Case: Convert everything to lowercase
    # This ensures "NTA", "Nta", and "nta" are all treated the same.
    normalized_text = text_passage.lower()

    # 2. Clean and Tokenize: Replace common punctuation with spaces
    # We loop through common punctuation marks and replace them with a single space.
    # The built-in 'string.punctuation' is useful here.
    for char in string.punctuation:
        # Example: 'Hello, NTA!' becomes 'Hello  NTA ' after replacement
        normalized_text = normalized_text.replace(char, ' ')

    # 3. Split: Break the cleaned text into a_all_threads of words (tokens)
    # The split() method handles multiple spaces correctly.
    # Example: 'Hello  NTA ' becomes ['Hello', 'NTA']
    word_all_threads = normalized_text.split()
    
    # 4. Check Membership: Look for the target in the_all_threads
    # 'in' is the simplest way to check for membership in a Python_all_threads.

    not_the_ahole = 'nta' in word_all_threads
    return not_the_ahole


#testing contains_nta() function
test_string1 = " You are NTA"
test_string2 = " ESH unfortunately"

not_the_ahole1 = contains_nta(test_string1)
not_the_ahole2 = contains_nta(test_string2)

print(f" The comment: {test_string1} scored : {not_the_ahole1} ")
print(f"The comment: {test_string2} scored : {not_the_ahole2}")

# aita_all_threads in now a_all_threads of the top 100 threads. Each thread in the list is a dict

one_thread = aita_all_threads[3]
#print(one_thread)

# use .keys() and .values() to figure out where the comments are, and then iterate through them.
# once you have the code working on one_thread, you can iterate through
# aita_all_threads and get the comments you need





# ----------------------------------------------------------------------
# --- Part to dump the list back to JSON ---
# ----------------------------------------------------------------------
# nta_posts : list[str] containing all the nta posts
try:
    with open(output_filename, 'w', encoding='utf-8') as file:
        # json.dump() serializes the Python object (aita_all_threads) to a JSON formatted file.
        # indent=4 makes the output file human-readable with 4-space indentation.
        # ensure_ascii=False allows non-ASCII characters (like emojis or special letters) to be written directly.
        json.dump(nta_posts, file, indent=4, ensure_ascii=False)
        print(f"Successfully dumped the list back to JSON in '{output_filename}'.")
except Exception as e:
    print(f"An error occurred while dumping JSON: {e}")