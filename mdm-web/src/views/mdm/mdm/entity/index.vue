<template>
  <div class="execution">
    <basic-container>
      <avue-crud ref="crud"
                 :page="page"
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
  import {addObj, delObj, fetchList, putObj} from '@/api/mdm/mdm/entity'
  import {tableOption} from '@/const/crud/mdm/mdm/entity'
  import {mapGetters} from 'vuex'

  export default {
    name: 'entity',
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
      getList(page, params) {
        this.tableLoading = true
        fetchList(Object.assign({
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
        this.$refs.crud.rowEdit(row, index)
      },
      handleDel(row, index) {
        this.$refs.crud.rowDel(row, index)
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
        putObj(row).then(() => {
          this.tableData.splice(index, 1, Object.assign({}, row))
          this.$message({
            showClose: true,
            message: '修改成功',
            type: 'success'
          })
          this.getList(this.page)
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

