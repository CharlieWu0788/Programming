def create_shopping_list():
    item_names = []
    item_prices = []
    total_cost = 0
    adding_items = True

    print("--- Welcome to the Buggy Shopping List Creator ---")
    print("Type 'done' when you are finished adding items.")

    while adding_items:
        name = input("Enter item name: ")
        if name.lower() == 'done':
            adding_items = False
        else:
            price = input(f"Enter price for {name}: ")
            item_names.append(name)
            item_prices.append(price)
            
    print("\n--- Your Shopping List ---")
    
    i = 0
   
    while i <= len(item_prices):
        price_str = int(item_prices[i])
        total_cost = total_cost + price_str
        #breakpoint()
        i = i + 1

    print(f"Total cost of your items: ${total_cost}")
    print("----------------------------")

if __name__ == "__main__":
    create_shopping_list()