<template>
  <div class="app-container calendar-list-container">
    <basic-container>
      <div class="filter-container">
        <el-button-group>
          <el-button type="primary"
                     icon="plus"
                     @click="handlerAdd">添加
          </el-button>
          <el-button type="primary"
                     icon="delete"
                     @click="handleDelete">删除
          </el-button>
        </el-button-group>
      </div>

      <el-row>
        <el-col :span="8"
                style='margin-top:15px;'>
          <el-tree class="filter-tree"
                   node-key="id"
                   highlight-current
                   :data="treeData"
                   :default-expanded-keys="aExpandedKeys"
                   :filter-node-method="filterNode"
                   :props="defaultProps"
                   @node-click="getNodeData"
                   @node-expand="nodeExpand"
                   @node-collapse="nodeCollapse">
          </el-tree>
        </el-col>
        <el-col :span="16"
                style='margin-top:15px;'>
          <el-card class="box-card">
            <el-form :label-position="labelPosition"
                     label-width="120px"
                     :model="form"
                     ref="form">
              <el-form-item label="节点组id"
                            prop="nodeGroupId">
                <el-input
                  v-model="form.nodeGroupId"
                  :disabled="formEdit"
                  placeholder="请输入节点组id"></el-input>
              </el-form-item>
              <el-form-item label="节点id"
                            prop="nodeId"
                            v-show="addHide">
                <el-input
                  v-model="form.nodeId"
                  :disabled="formEdit"
                  placeholder="请输入节点id"></el-input>
              </el-form-item>
              <el-form-item label="节点id"
                            prop="externalId"
                            v-show="addShow">
                <el-input v-model="form.externalId"
                          :disabled="formEdit"
                          placeholder="请输入节点id"></el-input>
              </el-form-item>
              <el-form-item label="数据库驱动"
                            prop="databaseDriver"
                            v-show="addShow">
                <el-select v-model="form.databaseDriver"
                          :disabled="formEdit"
                          placeholder="请选择数据库驱动">
                  <el-option label="com.mysql.jdbc.Driver" value="com.mysql.jdbc.Driver"></el-option>
                  <el-option label="oracle.jdbc.driver.OracleDriver" value="oracle.jdbc.driver.OracleDriver"></el-option>
                  <el-option label="org.postgresql.Driver" value="org.postgresql.Driver"></el-option>
                  <el-option label="org.apache.derby.jdbc.EmbeddedDriver" value="org.apache.derby.jdbc.EmbeddedDriver"></el-option>
                  <el-option label="org.hsqldb.jdbcDriver" value="org.hsqldb.jdbcDriver"></el-option>
                  <el-option label="net.sourceforge.jtds.jdbc.Driver" value="net.sourceforge.jtds.jdbc.Driver"></el-option>
                  <el-option label="com.ibm.db2.jcc.DB2Driver" value="com.ibm.db2.jcc.DB2Driver"></el-option>
                  <el-option label="com.informix.jdbc.IfxDriver" value="com.informix.jdbc.IfxDriver"></el-option>
                  <el-option label="org.firebirdsql.jdbc.FBDriver" value="org.firebirdsql.jdbc.FBDriver"></el-option>
                  <el-option label="interbase.interclient.Driver" value="interbase.interclient.Driver"></el-option>
                  <el-option label="org.sqlite.JDBC" value="org.sqlite.JDBC"></el-option>
                  <el-option label="com.sybase.jdbc4.jdbc.SybDriver" value="com.sybase.jdbc4.jdbc.SybDriver"></el-option>
                  <el-option label="com.nuodb.jdbc.Driver" value="com.nuodb.jdbc.Driver"></el-option>
                  <el-option label="org.h2.Driver" value="org.h2.Driver"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="数据库连接地址"
                            prop="databaseUrl"
                            v-show="addShow">
                <el-input v-model="form.databaseUrl"
                          :disabled="formEdit"
                          placeholder="请输入数据库连接地址"></el-input>
              </el-form-item>
              <el-form-item label="数据库连接用户"
                            prop="dbUser"
                            v-show="addShow">
                <el-input v-model="form.dbUser"
                          :disabled="formEdit"
                          placeholder="请输入数据库连接用户"></el-input>
              </el-form-item>
              <el-form-item label="数据库连接密码"
                            prop="dbPassword"
                            v-show="addShow">
                <el-input v-model="form.dbPassword"
                          :disabled="formEdit"
                          type="password"
                          placeholder="请输入数据库连接密码"></el-input>
              </el-form-item>
              <el-form-item label="心跳间隔时间"
                            prop="heartbeatInterval"
                            v-show="addHide">
                <el-input v-model="form.heartbeatInterval"
                          :disabled="formEdit"
                          placeholder="请输入心跳间隔时间"></el-input>
              </el-form-item>
              <el-form-item label="是否初始化加载"
                            prop="initialLoaded"
                            v-show="addHide">
                <el-input v-model="form.initialLoaded"
                          :disabled="formEdit"
                          placeholder="请输入是否初始化加载"></el-input>
              </el-form-item>
              <el-form-item label="上次心跳时间"
                            prop="lastHeartbeat"
                            v-show="addHide">
                <el-input class="filter-item"
                           v-model="form.lastHeartbeat"
                           :disabled="formEdit"
                          placeholder="请输入上次心跳时间"></el-input>
              </el-form-item>
              <el-form-item label="是否已注册"
                            prop="registered"
                            v-show="addHide">
                <el-input class="filter-item"
                          v-model="form.registered"
                          :disabled="formEdit"
                          placeholder="请输入是否已注册"></el-input>
              </el-form-item>
              <el-form-item label="注册服务器"
                            prop="registrationServer"
                            v-show="addHide">
                <el-input class="filter-item"
                          v-model="form.registrationServer"
                          :disabled="formEdit"
                          placeholder="请输入注册服务器"></el-input>
              </el-form-item>
              <el-form-item label="注册地址"
                            prop="registrationUrl"
                            v-show="addHide">
                <el-input class="filter-item"
                          v-model="form.registrationUrl"
                          :disabled="formEdit"
                          placeholder="请输入注册地址"></el-input>
              </el-form-item>
              <el-form-item label="同步路径"
                            prop="syncUrl"
                            v-show="addHide">
                <el-input class="filter-item"
                          v-model="form.syncUrl"
                          :disabled="formEdit"
                          placeholder="请输入同步路径"></el-input>
              </el-form-item>
              <el-form-item v-if="formStatus == 'create'">
                <el-button type="primary"
                           @click="create">保存
                </el-button>
                <el-button @click="onCancel">取消</el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </el-col>
      </el-row>
    </basic-container>
  </div>
</template>

<script>
  import {
    addObj,
    delObj,
    fetchMenuTree,
    getObj,
    putObj
  } from "@/api/mdm/sync/node";
  import { mapGetters } from "vuex";
  import iconList from "@/const/iconList";

  export default {
    name: "menu",
    data() {
      return {
        iconList: iconList,
        list: null,
        total: null,
        formEdit: false,
        addShow: true,
        addHide: true,
        menuIdNull: true,
        formAdd: true,
        formStatus: "",
        showElement: false,
        typeOptions: ["0", "1"],
        methodOptions: ["GET", "POST", "PUT", "DELETE"],
        listQuery: {
          name: undefined
        },
        treeData: [],
        oExpandedKey: {
          // key (from tree id) : expandedOrNot boolean
        },
        oTreeNodeChildren: {
          // id1 : [children] (from tree node id1)
          // id2 : [children] (from tree node id2)
        },
        aExpandedKeys: [],
        defaultProps: {
          children: "children",
          label: "name"
        },
        labelPosition: "right",
        form: {
          permission: undefined,
          name: undefined,
          menuId: undefined,
          parentId: undefined,
          icon: undefined,
          sort: undefined,
          component: undefined,
          type: undefined,
          path: undefined
        },
        currentId: -1,
        menuManager_btn_add: false,
        menuManager_btn_edit: false,
        menuManager_btn_del: false
      };
    },
    filters: {
      typeFilter(type) {
        const typeMap = {
          0: "菜单",
          1: "按钮"
        };
        return typeMap[type];
      }
    },
    created() {
      this.getList();
      this.menuManager_btn_add = this.permissions["sys_menu_add"];
      this.menuManager_btn_edit = this.permissions["sys_menu_edit"];
      this.menuManager_btn_del = this.permissions["sys_menu_del"];
    },
    computed: {
      ...mapGetters(["elements", "permissions"])
    },
    methods: {
      getList() {
        fetchMenuTree(this.listQuery).then(response => {
          this.treeData = response.data.data;
        });
      },
      filterNode(value, data) {
        if (!value) return true;
        return data.label.indexOf(value) !== -1;
      },

      nodeExpand(data) {
        let aChildren = data.children;
        if (aChildren.length > 0) {
          this.oExpandedKey[data.id] = true;
          this.oTreeNodeChildren[data.id] = aChildren;
        }
        this.setExpandedKeys();
      },
      nodeCollapse(data) {
        this.oExpandedKey[data.id] = false;
        // 如果有子节点
        this.treeRecursion(this.oTreeNodeChildren[data.id], oNode => {
          this.oExpandedKey[oNode.id] = false;
        });
        this.setExpandedKeys();
      },
      setExpandedKeys() {
        let oTemp = this.oExpandedKey;
        this.aExpandedKeys = [];
        for (let sKey in oTemp) {
          if (oTemp[sKey]) {
            this.aExpandedKeys.push(parseInt(sKey));
          }
        }
      },
      treeRecursion(aChildren, fnCallback) {
        if (aChildren) {
          for (let i = 0; i < aChildren.length; ++i) {
            let oNode = aChildren[i];
            fnCallback && fnCallback(oNode);
            this.treeRecursion(oNode.children, fnCallback);
          }
        }
      },

      getNodeData(data) {
        if (!this.formEdit) {
          this.formStatus = "update";
        }
        getObj(data.id).then(response => {
          this.form = response.data;
        });
        this.currentId = data.id;
        this.showElement = true;
        this.formEdit = true;
        this.addShow = false;
        this.addHide = true;
        this.menuIdNull = false;
      },
      handlerEdit() {
        if (this.form.menuId) {
          this.formEdit = false;
          this.menuIdNull = false;
          this.formStatus = "update";
        }
      },
      handlerAdd() {
        this.resetForm();
        this.formEdit = false;
        this.addShow = true;
        this.addHide = false;
        this.menuIdNull = true;
        this.formStatus = "create";
      },
      handleDelete() {
        this.$confirm("此操作将永久删除, 是否继续?", "提示", {
          confirmButtonText: "确定",
          cancelButtonText: "取消",
          type: "warning"
        }).then(() => {
          delObj(this.currentId).then(() => {
            this.getList();
            this.resetForm();
            this.onCancel();
            this.$notify({
              title: "成功",
              message: "删除成功",
              type: "success",
              duration: 2000
            });
          });
        });
      },
      update() {
        putObj(this.form).then(() => {
          this.getList();
          this.$notify({
            title: "成功",
            message: "更新成功",
            type: "success",
            duration: 2000
          });
        });
      },
      create() {
        addObj(this.form).then(() => {
          this.getList();
          this.$notify({
            title: "成功",
            message: "创建成功",
            type: "success",
            duration: 2000
          });
        });
      },
      onCancel() {
        this.formEdit = true;
        this.formStatus = "";
      },
      resetForm() {
        this.form = {
          parentId: this.currentId,
          nodeId: undefined,
          createdAtNodeId: undefined,
          externalId: undefined,
          databaseType: undefined,
          databaseVersion: undefined,
          hostName: undefined,
          heartbeatInterval: undefined,
          initialLoaded: undefined,
          lastHeartbeat: undefined,
          registered: undefined,
          registrationServer: undefined,
          registrationUrl: undefined,
          syncUrl: undefined
        };
      }
    }
  };
</script>

