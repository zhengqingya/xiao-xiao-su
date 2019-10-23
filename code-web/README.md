# 权限
src/store/modules/permission.js  ->  里设置 不使用权限

main.js  全局权限

按钮权限用法  （ 按钮级权限管控 - ）  可参考 https://blog.csdn.net/qq_37143673/article/details/93723028
<el-button
        v-waves
        v-has="'userList:add'"
        class="filter-item"
        style="margin-left: 10px;"
        type="primary"
        icon="el-icon-plus"
        @click="handleCreate"
      >
        {{ $t('table.add') }}
      </el-button>

src/store/modules/user.js  ->  后端返回权限


# 路由
src/router/index.js -> 引入模块路由
src/router/modules -> 配置模块路由

# 分页全局组件
<cus-pagination v-show="total>0" :total="total" :page.sync="listQuery.page" :limit.sync="listQuery.limit" @pagination="getList"/>

### 权限白名单配置 -> src/permission.js
```
const whiteList = ['/login', '/auth-redirect' , '/qqLogin']  <!-- 不重定向白名单 -->
```

### 按钮名  ` {{ $t('table.add') }} `
src/lang/zh.js