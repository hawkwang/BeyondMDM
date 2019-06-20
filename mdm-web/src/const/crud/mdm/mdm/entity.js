
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
    label: '模型',
    prop: 'modelId',
    type: 'select',
    searchClearable:false,
    dicUrl: '/mdm/model/dict',
    search: true
  }, {
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
    prop: 'desc',
    rules: [{
      required: true,
      message: '请输入说明',
      trigger: 'blur'
    }]
  }, {
    label: '创建临时表',
    prop: 'hasTempTable',
    type: 'radio',
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '是否创建临时表',
      trigger: 'blur'
    }]
  }, {
    label: '模型Id',
    prop: 'modelId',
    editDisabled: true,
    addVisdiplay:false
  }, {
    label: '自动创建代码',
    prop: 'codeAutomatic',
    type: 'radio',
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '自动创建代码',
      trigger: 'blur'
    }]
  }, {
    label: '创建者id',
    prop: 'createId',
    editDisabled: true,
    addVisdiplay:false
  }, {
    label: '创建时间',
    prop: 'createTime',
    type: 'datetime',
    valueFormat:'timestamp',
    editDisabled: true,
    addVisdiplay:false
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
    addVisdiplay:false,
  }]
}
