/**
 * 同步管理
 */
export const tableOption = {
  border: true,
  index: true,
  indexLabel: '序号',
  stripe: true,
  menuAlign: 'center',
  align: 'center',
  refreshBtn: false,
  showClomnuBtn: false,
  searchSize: 'mini',
  viewBtn: true,
  editBtn: false,
  delBtn: false,
  column: [{
    label: '任务名称',
    prop: 'jobName',
    searchClearable:false,
    editDisabled:true,
    search: true
  },{
    width: 150,
    label: '描述',
    prop: 'description',
    rules: [{
      required: true,
      message: '请输入描述',
      trigger: 'blur'
    }]
  }, {
    label: '调度',
    prop: 'schedule',
    rules: [{
      required: true,
      message: '请输入显示名称',
      trigger: 'blur'
    }]
  },{
    label: '任务类型',
    prop: 'jobType',
    hide: true,
    type: 'select',
    rules: [{
      required: true,
      message: '请输入任务类型',
      trigger: 'blur'
    }],
    dicData: [{
      label: 'BSH',
      value: 'BSH'
    }, {
      label: 'JAVA',
      value: 'JAVA'
    },{
    label: 'SQL',
    value: 'SQL'
  }]
  },{
    label: '是否自动开始',
    prop: 'automaticStartup',
    hide: true,
    type: 'select',
    rules: [{
      required: true,
      message: '请选择是否自动开始',
      trigger: 'blur'
    }],
    dicData: [{
      label: '是',
      value: true
    }, {
      label: '否',
      value: false
    }]
  },{
    label: '任务表达式',
    prop: 'jobExpression',
    hide: true,
    rules: [{
      required: true,
      message: '请输入任务表达式',
      trigger: 'blur'
    }]
  },{
    label: '运行中',
    prop: 'running',
    addVisdiplay:false,
    rules: [{
      required: true,
      message: '状态',
      trigger: 'blur'
    }]
  },{
    label: '已启动',
    prop: 'started',
    addVisdiplay:false,
    rules: [{
      required: true,
      message: '已启动',
      trigger: 'blur'
    }]
  },{
    label: '上次执行间隔',
    prop: 'lastExecutionTimeInMs',
    addVisdiplay:false,
    rules: [{
      required: true,
      message: '上次执行间隔',
      trigger: 'blur'
    }]
  },{
    label: '平均执行时长',
    prop: 'averageExecutionTimeInMs',
    type: 'number',
    addVisdiplay:false,
    rules: [{
      required: true,
      message: '平均执行时间',
      trigger: 'blur'
    }]
  },{
    label: '上次结束事件',
    prop: 'lastFinishTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
    editDisabled: true,
    addVisdiplay:false
  },{
    label: '下次执行时间',
    prop: 'nextExecutionTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
    editDisabled: true,
    addVisdiplay:false
  }]
}
