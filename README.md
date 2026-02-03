# 介绍

替换 https://updates.jenkins.io/update-center.json 中的插件地址为阿里云镜像站

# 使用方法

使用管理员账号访问你的jenkins：http://IP:PORT/manage/pluginManager/advanced

页面最下方粘贴：https://raw.githubusercontent.com/baofeidyz/jenkins-mirror/refs/heads/main/update-center-aliyun.json
然后提交即可

# FAQ

如果你的jenkins服务无法访问raw.githubusercontent.com，你就自己下载放到本地，然后通过一些本地服务提供即可
