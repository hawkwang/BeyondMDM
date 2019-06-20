
const DIC = {
  vaild: [{
    label: '否',
    value: '0'
  }, {
    label: '是',
    value: '1'
  }]
}

export const preDict = [{
    label: 'Code',
    value: ''
  }, {
    label: 'Name',
    value: '1'
}]

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
    prop: 'mEntitiesId',
    type: 'tree',
    searchClearable:false,
    dicUrl: '/mdm/entity/meTree',
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
    label: '是否唯一',
    prop: 'isSingle',
    type: 'radio',
    dicData: DIC.vaild,
    rules: [{
      required: false,
      message: '请选择是否唯一',
      trigger: 'blur'
    }]
  },{
    label: '选择属性',
    prop: 'attrs',
    type: 'checkbox',
    dicData: preDict
  },{
    label: '创建者id',
    prop: 'createId',
    editDisabled: true,
    addVisdiplay:false,
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
    addVisdiplay:false,
  }]
}
