import httpclient, json, strutils, sequtils, tables
export httpclient.HttpClient

proc preLogin (client: HttpClient, verbose: bool = false): bool =
  const url = "https://kancolle-arcade.net/ac/"
  client.headers = newHttpHeaders({
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
  })
  let response = client.request(url, HttpGet)
  if verbose: echo "[login]prelogin(" & response.status & ")"
  result = response.status == "200 OK"

proc login*(client: HttpClient, id: string, pass: string, verbose: bool = false): string =
  const url = "https://kancolle-arcade.net/ac/api/Auth/login"
  discard client.preLogin verbose
  client.headers = newHttpHeaders({
    "Content-Type": "application/json;charset=UTF-8",
    "Referer": "https://kancolle-arcade.net/ac",
    "User-Agent": "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_4) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/66.0.3359.117 Safari/537.36",
    "X-Requested-With": "XMLHttpRequest",
  })
  let body = %*{"id": id, "password": pass}
  let response = client.request(url, HttpPost, $body)
  if verbose: echo "[login]login(" & response.status & ")"
  if response.status == "200 OK":
    let cookies = response.headers.table["set-cookie"]
    result = cookies[cookies.len - 1].split(";")[0]

