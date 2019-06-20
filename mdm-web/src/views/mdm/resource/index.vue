`<script src="../../../api/mdm/resource.js"></script>
<template>
  <div class="execution">
    <basic-container>
      <avue-form :option="option"
                 v-model="form"
                 @submit="handleSubmit"></avue-form>
      <avue-crud ref="crud"
                 :page="page"
                 :data="tableData"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @on-load="loadDefault"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @search-change="searchChange"
                 @row-del="rowDel">
        <template slot-scope="scope"
                  slot="menu">
          <el-button type="text"
                     icon="el-icon-check"
                     size="mini"
                     plain
                     @click="handleEdit(scope.row,scope.index)">编辑
          </el-button>
          <el-button type="text"
                     icon="el-icon-delete"
                     size="mini"
                     plain
                     @click="handleDel(scope.row,scope.index)">删除
          </el-button>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import {getOptions, getResourceList, updateResource, addResource, delResource} from '@/api/mdm/resource'
  import {tableOption, option} from '@/const/crud/mdm/resource/resource'
  import {mapGetters} from 'vuex'

  export default {
    name: 'dict',
    data() {
      return {
        tableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20 // 每页显示多少条
        },
        tableLoading: false,
        tableOption: tableOption,
        option: option,
        currentEntity: '',
        form: {
          modelId: '',
          entity: ''
        },
        oldCode: ''
      }
    },
    created() {

    },
    mounted: function () {
    },
    computed: {
      ...mapGetters(['permissions'])
    },
    methods: {
      //获取默认实体结构，实体数据
      loadDefault(page){
        getOptions("default").then(data => {
          this.tableOption = data.data.data;
          this.currentEntity = data.data.data.entityId;
          var params = {entityId: this.currentEntity}
          getResourceList(Object.assign({
            current: page.currentPage,
            size: page.pageSize
          }, params)).then(response => {
            console.log(response.data)
            this.tableData = response.data.data.records
            this.page.total = response.data.data.total
            this.tableLoading = false
          })

        })
      },
      getList(page, params) {
        this.tableLoading = true;
        var params = {entityId: this.currentEntity}
        getResourceList(Object.assign({
          current: page.currentPage,
          size: page.pageSize
        }, params)).then(response => {
          this.tableData = response.data.data.records
          this.page.total = response.data.data.total
          this.tableLoading = false
        })
      },
      /**
       * @title 打开新增窗口
       * @detail 调用crud的handleadd方法即可
       *
       **/
      handleAdd: function () {
        this.$refs.crud.rowAdd()
      },
      handleEdit(row, index) {
          console.log("test")
        this.oldCode = row.Code
        this.$refs.crud.rowEdit(row, index)
      },
      handleDel(row, index) {
        this.$refs.crud.rowDel(row, index)
        row.entityId= this.currentEntity
      },
      rowDel: function (row, index) {
        var _this = this
        this.$confirm('是否确认删除标签名为"' + row.label + '",数据类型为"' + row.type + '"的数据项?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
            console.log(row)
          return delResource(row)
        }).then(() => {
          this.getList(this.page)
          _this.$message({
            showClose: true,
            message: '删除成功',
            type: 'success'
          })
        }).catch(function () {
        })
      },
      /**
       * @title 数据更新
       * @param row 为当前的数据
       * @param index 为当前更新数据的行数
       * @param done 为表单关闭函数
       *
       **/
      handleUpdate: function (row, index, done) {
        updateResource(Object.assign({
          entityId: this.currentEntity,
          oldCode: this.oldCode
        }, row)).then(() => {
          this.tableData.splice(index, 1,
            Object.assign({
              entityId: this.currentEntity
            }, row))
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          this.getList(this.page)
          done()
        })
      },
//      获取实体的字段
      handleSubmit: function (form) {
        console.log(form)
        this.currentEntity = form.entity
        getOptions(form.entity).then(data => {
          console.log(data.data.data);
          this.tableOption = data.data.data;
          var params = {entityId: this.currentEntity}
          getResourceList(Object.assign({
            current: this.page.currentPage,
            size: this.page.pageSize
          }, params)).then(response => {
            this.tableData = response.data.data.records
            this.page.total = response.data.data.total
            this.tableLoading = false
          })
        })
        console.log(data)
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave: function (row, done) {
        row.entityId = this.currentEntity
        console.log(row)
        addResource(row).then(data => {
          this.tableData.push(Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          this.getList(this.page)
          done()
        })
      },
      searchChange(form) {
        this.getList(this.page, form)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>

