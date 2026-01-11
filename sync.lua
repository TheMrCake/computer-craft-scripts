local userName = "TheMrCake"
local repo = "computer-craft-scripts"

local apiUrl = "https://api.github.com/repos/"..userName.."/"..repo.."/contents/"

local initialResponse = http.get(apiUrl) or error("Couldn't connect to the repo.")
local initialResponseText = initialResponse.readAll() or error("Can't be read")
initialResponse.close()

local repoData = textutils.unserializeJSON(initialResponseText, {})

local ignoredFiles = {
  [".luarc.json"] = true,
  [".gitignore"] = true,
  ["LICENSE"] = true,
}

local function downloadFolder(data, path)
  for _, item in ipairs(data) do
    if ignoredFiles[item.name] then
      goto continue
    end

    if item.type == "file" then
      local rawUrl = item.download_url
      print(item.name)
      shell.run("wget", rawUrl, "./"..path.."/"..item.name)
    elseif item.type == "dir" then
      shell.run("mkdir", item.path)
      local responseText = http.get(apiUrl..item.path).readAll() or error("Can't find folder: "..item.path)
      downloadFolder(textutils.unserializeJSON(responseText, {}), item.path)
    end
      ::continue::
  end
end

downloadFolder(repoData, "")
