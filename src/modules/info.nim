import httpclient, strutils
export httpclient.HttpClient

proc info*(client: HttpClient, api_url: string, cookie: string, verbose: bool = false): string =
  let url = "https://kancolle-arcade.net/ac/api/" & api_url
  client.headers = newHttpHeaders({
    "Content-Type": "application/json;charset=UTF-8",
    "Referer": "https://kancolle-arcade.net/ac",
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
    "Cookie": cookie,
  })
  let response = client.request(url, HttpGet)
  if verbose: echo "[get]" & api_url & "(" & response.status & ")"
  if response.status == "200 OK":
    result = response.body
  else:
    result =  ""

