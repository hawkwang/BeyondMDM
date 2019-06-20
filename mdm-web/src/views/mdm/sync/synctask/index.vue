<template>
  <div class="execution">
    <basic-container>
      <avue-crud ref="crud"
                 :data="tableData"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @on-load="getList"
                 @row-update="handleUpdate"
                 @row-save="handleSave"
                 @search-change="searchChange">
        <template slot-scope="scope"
                  slot="menu">
          <el-button type="text"
                     icon="el-icon-check"
                     size="mini"
                     plain
                     @click="rowStart(scope.row,scope.index)">开启
          </el-button>
          <el-button type="text"
                     icon="el-icon-delete"
                     size="mini"
                     plain
                     @click="handleDel(scope.row,scope.index)">停止
          </el-button>
        </template>
      </avue-crud>
    </basic-container>
  </div>
</template>

<script>
  import {addObj, startJob, stopJob,fetchList, putObj} from '@/api/mdm/sync/sync'
  import {tableOption} from '@/const/crud/mdm/sync/sync'
  import {mapGetters} from 'vuex'

  export default {
    name: 'attr',
    data() {
      return {
        tableData: [],
        tableLoading: false,
        tableOption: tableOption
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
        }, params)).then(response => {
          this.tableData = response.data.data
          this.tableData.forEach(function (item,index) {
              item.description = item.jobDefinition.description
          })
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
      handleStart(row, index){
        this.$refs.crud.rowStart(row, index)
      },
      rowStart(row, index){
        var _this = this
        this.$confirm('是否确认执行 "' + row.jobName + '" 任务？"', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return startJob(row)
        }).then(() => {
          this.getList()
        }).catch(function () {
        })
      },
//      停止任务
//      handleDel(row, index) {
//        this.$refs.crud.rowDel(row, index)
//      },
      handleDel: function (row, index) {
        var _this = this
        this.$confirm('是否确认停止 "' + row.label + '" 任务"', '警告', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return stopJob(row)
        }).then(() => {
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
        console.log(row);
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

