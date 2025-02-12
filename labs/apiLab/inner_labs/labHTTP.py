import httpx

if __name__ == '__main__':

    user_choice = input("would you like to look a user by id or name? (id/name): ")

    if user_choice == "id":
        user_input = input("please supply user id: ")
        res = httpx.get(f"https://jsonplaceholder.typicode.com/users/{user_input}")

        if res.status_code == 200:
            print(res.text)

        elif res.status_code == 404:
            print("user not found")

        elif res.status_code == 500:
            print("server error")

    if user_choice == "name":

        user_input = input("please supply user name: ")
        res = httpx.get(f"https://jsonplaceholder.typicode.com/users/", params={"name": user_input})

        if res.status_code == 200:
            print(res.text)

        else:
            print("something went wrong with the request")