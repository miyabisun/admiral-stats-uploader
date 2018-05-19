import httpclient, strutils

proc info*(api_url: string, cookie: string): string =
  let url = "https://kancolle-arcade.net/ac/api/" & api_url
  echo url
  let client = newHttpClient()
  client.headers = newHttpHeaders({
    "Content-Type": "application/json;charset=UTF-8",
    "Referer": "https://kancolle-arcade.net/ac",
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
    "Cookie": cookie,
  })
  let response = client.request(url, HttpGet)
  echo response.status
  if response.status == "200 OK":
    result = response.body
  else:
    result =  ""

