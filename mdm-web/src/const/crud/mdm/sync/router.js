
const DIC = {
  vaild: [{
    label: '整数',
    value: 'int'
  }, {
    label: '可变字符串',
    value: 'varchar'
  }, {
    label: '文本',
    value: 'text'
  }, {
    label: '日期',
    value: 'datetime'
  }]
}
const baseUrl = `/mdm`
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
    label: '所属实体',
    prop: 'entityId',
    type: 'tree',
    searchClearable:false,
    editDisabled:true,
    dicUrl: baseUrl+'/entity/meTree',
    search: true
  },{
    width: 150,
    label: '名称',
    prop: 'name',
    rules: [{
      required: true,
      message: '请输入名称',
      trigger: 'blur'
    }]
  }, {
    label: '显示名称',
    prop: 'showName',
    rules: [{
      required: true,
      message: '请输入显示名称',
      trigger: 'blur'
    }]
  },{
    label: '说明',
    prop: 'desc',
    rules: [{
      required: true,
      message: '请输入说明',
      trigger: 'blur'
    }]
  },{
    label: '数据类型',
    prop: 'dataType',
    type: 'select',
    dicData: DIC.vaild,
    rules: [{
      required: true,
      message: '请选择数据类型',
      trigger: 'blur'
    }]
  },{
    label: '数据限制',
    prop: 'dataLimit',
    type: 'number',
    rules: [{
      required: true,
      message: '请输入数据限制',
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
