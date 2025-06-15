# BloomSphere 花卉管理系统

BloomSphere是一个基于Java Web技术开发的花卉管理与社区系统，为花卉爱好者提供一个交流分享和花卉管理的平台。

## 项目功能

### 花卉管理
- 花卉列表展示
- 按名称和类别搜索花卉
- 添加、编辑和删除花卉信息（管理员功能）
- 花卉库存和价格管理

### 用户系统
- 用户注册与登录
- 密码修改
- 管理员权限控制

### 花友论坛
- 浏览帖子列表
- 查看帖子详情
- 发表新帖
- 回复讨论

## 技术栈

- **前端**：JSP, HTML, CSS, JavaScript
- **后端**：Java Servlet
- **数据库**：MySQL
- **开发环境**：Eclipse
- **服务器**：Tomcat

## 项目结构

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── bloomsphere/
│   │           ├── model/      # 数据模型
│   │           ├── servlet/    # Servlet控制器
│   │           └── util/       # 工具类
│   └── webapp/
│       ├── WEB-INF/            # Web配置
│       ├── META-INF/           # 元数据
│       ├── *.jsp               # JSP页面
│       └── ...
```

## 安装与部署

### 环境要求
- JDK 8+
- Tomcat 8+
- MySQL 5.7+

### 部署步骤

1. 克隆项目到本地
   ```
   git clone https://github.com/yourusername/FlowerSphere.git
   ```

2. 在Eclipse中导入项目
   - 选择 `File > Import > Existing Projects into Workspace`
   - 选择项目目录并导入

3. 配置数据库
   - 创建名为`bloomsphere`的数据库
   - 导入`database/bloomsphere.sql`文件初始化数据库结构

4. 配置Tomcat服务器
   - 在Eclipse中添加Tomcat服务器
   - 将项目部署到Tomcat

5. 启动服务器
   - 启动Tomcat服务器
   - 访问`http://localhost:8080/FlowerSphere`

## 使用指南

### 管理员账号
- 用户名：admin
- 密码：admin123

### 普通用户
- 可以通过注册页面创建新账号
- 或使用测试账号：user/user123

## 项目截图

（此处可添加系统截图）

## 贡献指南

1. Fork 本仓库
2. 创建您的特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交您的更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 打开一个 Pull Request

## 许可证

本项目采用 MIT 许可证 - 详情请见 [LICENSE](LICENSE) 文件 