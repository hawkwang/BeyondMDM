
const DIC = {
  vaild: [{
    label: '否',
    value: '0'
  }, {
    label: '是',
    value: '1'
  }]
}

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
    width: 150,
    label: '名称',
    prop: 'name',
    rules: [{
      required: true,
      message: '请输入名称',
      trigger: 'blur'
    }]
  }, {
    label: '说明',
    prop: 'description',
    rules: [{
      required: true,
      message: '请输入说明',
      trigger: 'blur'
    }]
  }, {
    label: '是否保存日志',
    prop: 'logSave',
    type: 'radio',
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '请选择是否保存日志',
      trigger: 'blur'
    }]
  },{
    label: '日志保留天数',
    prop: 'saveDays',
    type: 'number',
    rules: [{
      required: true,
      message: '请输入日志保留天数',
      trigger: 'blur'
    }]
  }, {
    label: '创建者',
    prop: 'createId',
    editDisabled: true,
    addVisdiplay:false,
  },{
    label: '创建时间',
    prop: 'createTime',
    type: 'datetime',
    valueFormat:'timestamp',
    editDisabled: true,
    addVisdiplay:false,
    format: 'yyyy-MM-dd HH:mm'
  },{
    label: '更新者id',
    prop: 'updateId',
    editDisabled: true,
    addVisdiplay:false
  }, {
    label: '更新时间',
    prop: 'updateTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
    editDisabled: true,
    addVisdiplay:false
  }]
}
