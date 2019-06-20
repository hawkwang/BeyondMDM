<!--
  -    Copyright (c) 2018-2025, lengleng All rights reserved.
  -
  - Redistribution and use in source and binary forms, with or without
  - modification, are permitted provided that the following conditions are met:
  -
  - Redistributions of source code must retain the above copyright notice,
  - this list of conditions and the following disclaimer.
  - Redistributions in binary form must reproduce the above copyright
  - notice, this list of conditions and the following disclaimer in the
  - documentation and/or other materials provided with the distribution.
  - Neither the name of the pig4cloud.com developer nor the names of its
  - contributors may be used to endorse or promote products derived from
  - this software without specific prior written permission.
  - Author: lengleng (wangiegie@gmail.com)
  -->

<template>
  <div class="execution">
    <basic-container>
      <avue-crud ref="crud"
                 :page="page"
                 :data="tableData"
                 @on-load="getList"
                 :table-loading="tableLoading"
                 :option="tableOption"
                 @refresh-change="refreshChange">
        <template slot-scope="scope"
                  slot="menuBtn">
          <el-dropdown-item divided
                            v-if="permissions.act_task_manage"
                            @click.native="audit(scope.row,scope.index)">审批
          </el-dropdown-item>
          <el-dropdown-item divided
                            v-if="permissions.act_task_manage"
                            @click.native="comment(scope.row,scope.index)">批注
          </el-dropdown-item>
          <el-dropdown-item divided
                            v-if="permissions.act_task_manage"
                            @click.native="viewPic(scope.row,scope.index)">流程图
          </el-dropdown-item>
        </template>
      </avue-crud>
    </basic-container>
    <el-dialog title="任务办理"
               :visible.sync="showTask">
      <avue-form ref="form" v-model="obj" :option="formOption">
        <template slot-scope="scope" slot="menuForm">
          <el-button icon="el-icon-check"
                     v-for="flag in flagList" :key="flag"
                     @click="handleTask(scope.row,flag)"
                     plain>{{flag}}
          </el-button>
        </template>
      </avue-form>
    </el-dialog>
    <el-dialog title="批注列表"
               :visible.sync="showComment">
      <avue-crud :data="taskTableData" :option="taskOption"></avue-crud>
    </el-dialog>
    <el-dialog title="流程图"
               :visible.sync="showPicDialog">
      <img :src="actPicUrl" v-if="showPicDialog" width="100%">
    </el-dialog>
  </div>
</template>

<script>
  import {doTask, fetchComment, fetchDetail, fetchList} from '@/api/activiti/task'
  import {formOption, tableOption, taskOption} from '@/const/crud/activiti/task'
  import {mapGetters} from 'vuex'

  export default {
    name: 'task',
    data() {
      return {
        actPicUrl: '',
        obj: {},
        flagList: {},
        showTask: false,
        showComment: false,
        showPicDialog: false,
        tableData: [],
        taskTableData: [],
        page: {
          total: 0, // 总页数
          currentPage: 1, // 当前页数
          pageSize: 20 // 每页显示多少条
        },
        tableLoading: false,
        tableOption: tableOption,
        formOption: formOption,
        taskOption: taskOption,
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

      audit: function (row, index) {
        fetchDetail(row.taskId).then(response => {
          this.obj = response.data.data
          // 根据连线判断下次的流程
          this.flagList = this.obj.flagList
          this.showTask = true
        })
        this.obj = row
      },
      comment: function (row, index) {
        fetchComment(row.taskId).then(response => {
          this.taskTableData = response.data.data
        })
        this.showComment = true
      },
      handleSubmit: function (row, index) {
        var _this = this
        this.$confirm('是否确认提交ID为' + row.leaveId, '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(function () {
          return submit(row.leaveId)
        }).then(data => {
          _this.tableData.splice(index, 1)
          _this.$message({
            showClose: true,
            message: '提交成功',
            type: 'success'
          })
        }).catch(function (err) {
        })
      },
      handleTask: function (row, result) {
        this.obj.taskFlag = result
        doTask(this.obj).then(response => {
          this.$message({
            showClose: true,
            message: '提交成功',
            type: 'success'
          })
          this.showTask = false
          this.getList(this.page)
        })
      },
      viewPic: function (row, index) {
        this.actPicUrl = `/act/task/view/` + row.taskId
        this.showPicDialog = true
      },
      /**
       * 刷新回调
       */
      refreshChange() {
        this.getList(this.page)
      }
    }
  }
</script>

<style lang="scss" scoped>
</style>

