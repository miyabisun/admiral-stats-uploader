import httpclient, json, strutils, sequtils, tables

proc preLogin (client: HttpClient): bool =
  const url = "https://kancolle-arcade.net/ac/"
  client.headers = newHttpHeaders({
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
  })
  let response = client.request(url, HttpGet)
  result = response.status == "200 OK"

proc login* (id: string, pass: string): string =
  let client = newHttpClient()
  echo "top-page: " & $preLogin client
  const url = "https://kancolle-arcade.net/ac/api/Auth/login"
  client.headers = newHttpHeaders({
    "Content-Type": "application/json;charset=UTF-8",
    "Referer": "https://kancolle-arcade.net/ac",
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
  })
  let body = %*{"id": id, "password": pass}
  let response = client.request(url, HttpPost, $body)
  echo "login-status: ", response.status
  if response.status == "200 OK":
    let cookies = response.headers.table["set-cookie"]
    result = cookies[cookies.len - 1].split(";")[0]
  else:
    result =  ""

