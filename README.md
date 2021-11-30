# 项目部署说明

1. git clone

   https://github.com/Charles-Ma291/OlympicWeb-2021.git

2. 环境配置

   为了能够运行本项目，电脑上至少应有：

   服务器：Apache/2.4.51 (Win64) OpenSSL/1.1.1l PHP/7.4.26

   数据库：libmysql – mysqlnd 7.4.26

   数据库管理工具（可选）：phpMyAdmin 5.1.1 / Navicat 15.0.27

   为了方便集成和连接，推荐使用xampp：

   https://www.apachefriends.org/zh_cn/download.html

3. 项目环境搭建

   本项目是基于yii2框架实现的，要启动项目请先确认电脑上已安装yii2或composer，后者是一个php管理工具，可以使用它来安装yii2。具体操作：安装composer后在htdocs内启动cmd执行

   ![img](file://clip_image002.jpg)

   完成后执行php init进行初始化

4. 导入数据库

   项目内部提供了sql文件，导入之前应执行数据库迁移：在项目目录中cmd输入

   “yii.bat migrate”，然后创建一个数据库（例如mydatabase）。cmd中输入

   “mysql -u root -p”后输入”create database mydatabase;”；

   下一步是导入sql文件。安装了navicat可以直接使用它导入；没有安装的话需进行以下步骤：1. 打开mysql    2. “use mydatabase”  3. “source <\sql路径>”注意把’\’换成’/’

   完成后，访问http://localhost/advanced/frontend/web/index.php截图如下：

   ![img](file://clip_image004.png)

   ![img](file://clip_image006.png)

   项目成功部署并连接数据库。

   访问后台http://localhost/advanced/backend/web/index.php，需要从前台先进行注册，注册之后可以登录后台进行管理。
