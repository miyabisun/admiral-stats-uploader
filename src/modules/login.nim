import httpclient, json
const url = "https://kancolle-arcade.net/ac/api/Auth/login"

proc login* (id: string, pass: string): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({
    "Content-Type": "application/json",
    "Origin": "https://kancolle-arcade.net",
    "Accept": "application/json, text/plain, */*",
    "Referer": "https://kancolle-arcade.net/ac",
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
  })
  let body = %*{"id": id, "password": pass}
  let response = client.request(url, HttpPost, $body)
  echo "status: ", response.status
  echo "body: ", response.body
  if response.status == "200 OK":
    result = response.headers["set-cookie"]
  else:
    result =  ""

export login

