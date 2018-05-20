import os, httpclient

proc upload* (token: string, file_type: string, body: string, time: string): bool =
  let url = "https://www.admiral-stats.com/api/v1/import/" & file_type & "/" & time
  echo url
  let client = newHttpClient()
  client.headers = newHttpHeaders({
    "Content-Type": "application/json",
    "User-Agent": "AdmiralStatsExporter-Nim-CLI",
    "Authorization": "Bearer " & token,
  })
  let response = client.request(url, HttpPost, body)
  echo file_type & "(" & response.status & "): " & response.body
  result = response.status == "201 Created" or response.status == "200 OK"

