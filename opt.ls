require! <[fs]>
opt =
  port: 8315
  host: \localhost
if fs.exists-sync \option/port then opt.port = parseInt fs.read-file-sync \option/port encoding: \utf8
if fs.exists-sync \option/host then opt.host = (fs.read-file-sync \option/host encoding: \utf8) - \\n
module.exports = opt
