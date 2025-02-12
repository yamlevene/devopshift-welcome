import httpx
from time import sleep

if __name__ == '__main__':

    repeat = 3
    sleep_interval = 2
    ok = 0

    headers = {"Authorization": "Bearer YOUR_API_KEY"}
    url_params = "metrics=cpu,memory"
    print("fetching system metrics...")

    for i in range(repeat):

        try:
            res = httpx.get(f"https://api.example.com/system/metrics?{url_params}", headers=headers)
            print(res.text)
            ok = 1
            break

        except Exception as e:
            print(f"Attempt {i + 1} failed: Server is currently down.")
            print(f"Retrying in {sleep_interval} seconds...")
            if i < 2:
                sleep(sleep_interval)

    if not ok:
        print("All retry attempts failed.")
