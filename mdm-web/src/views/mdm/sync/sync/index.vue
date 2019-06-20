<template>
  <div class="execution">
    <basic-container>
      <avue-crud ref="crud"
                 :data="tableData"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @on-load="getList"
                 @search-change="searchChange"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @row-del="rowDel">
        <template slot-scope="scope"
                  slot="menu">
          <el-button type="text"
                     icon="el-icon-check"
                     size="mini"
                     plain
                     @click="rowSync(scope.row,scope.index)">执行同步
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
  import {addObj, delObj, fetchList, putObj,tableSync} from '@/api/mdm/sync/sync'
  import {tableOption} from '@/const/crud/mdm/sync/sync'
  import {mapGetters} from 'vuex'

  export default {
    name: 'entity',
    data() {
      return {
        tableData: [],
        tableLoading: false,
        tableOption: tableOption,
        model:undefined
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
      getList( params) {
        this.tableLoading = true
        fetchList(params).then(response => {
          this.tableData = response.data.data.records
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
      handleSync(row, index) {
        this.$refs.crud.rowSync(row, index)
      },
      handleDel(row, index) {
        this.$refs.crud.rowDel(row, index)
      },
      rowSync: function (row, index){
        var _this = this
        this.$confirm('是否确认同步"' + row.label + '",数据类型为"' + row.type + '"的数据项?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return tableSync(row)
        }).then(() => {
          _this.$message({
            showClose: true,
            message: '执行成功',
            type: 'success'
          })
        }).catch(function () {
        })
      },
      rowDel: function (row, index) {
        var _this = this
        this.$confirm('是否确认删除标签名为"' + row.label + '",数据类型为"' + row.type + '"的数据项?', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return delObj(row)
        }).then(() => {
          this.getList()
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
        putObj(row).then(() => {
          this.tableData.splice(index, 1, Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          this.getList()
          done()
        })
      },
      /**
       * @title 数据添加
       * @param row 为当前的数据
       * @param done 为表单关闭函数
       *
       **/
      handleSave: function (row, done) {
        addObj(row).then(data => {
          this.tableData.push(Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '添加成功',
            type: 'success'
          })
          this.getList()
          done()
        })
      },
      searchChange(form) {
        this.getList(form)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>

