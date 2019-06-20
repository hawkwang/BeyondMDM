
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
    label: '描述',
    prop: 'desc',
    rules: [{
      required: false,
      message: '请输入描述',
      trigger: 'blur'
    }]
  }, {
    label: '是否发布',
    prop: 'publish',
    type: 'radio',
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '请选择是否发布',
      trigger: 'blur'
    }]
  },{
    label: '创建者id',
    prop: 'createId',
    editDisabled: true,
    addVisdiplay:false
  },{
    label: '创建时间',
    prop: 'createTime',
    type: 'datetime',
    valueFormat:'timestamp',
    format: 'yyyy-MM-dd HH:mm',
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
    addVisdiplay:false
  }]
}
