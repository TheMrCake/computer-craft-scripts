local userName = "TheMrCake"
local repo = "computer-craft-scripts"

-- Working Directory
local wd = fs.getDir(shell.getRunningProgram())

local apiUrl = "https://api.github.com/repos/"..userName.."/"..repo.."/contents/"

local response = http.get(apiUrl) or error("Fuck, this shouldn't happen. Couldn't connect to the repo.")
local responseText = response.readAll() or error("Can't be read")
response.close()

local repoData = textutils.unserializeJSON(responseText, {})

local ignoredFiles = {
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
      shell.run("wget", rawUrl, wd..path..item.name)
    elseif item.type == "dir" then
      fs.makeDir(wd..item.path)
      downloadFolder(http.get(apiUrl..item.path) or error("Can't find folder: "..item.path), item.path)
    end
      ::continue::
  end
end

downloadFolder(repoData, "")
