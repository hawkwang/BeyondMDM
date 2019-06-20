const DIC = {
  vaild: [ {
    label: '是',
    value: true
  }, {
    label: '否',
    value: false
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
      label:'id',
      prop:'id',
      hide:true,
      addVisdiplay:false,
      editDisabled: false,
  },{
      label: '所属实体',
      prop: 'entityId',
      hide:false,
      type:'tree',
      dicUrl: baseUrl+'/entity/meTree',
      addVisdiplay:true,
      editDisabled:true
  },{
    width: 150,
    hide:true,
    label: '实体名称',
    prop: 'tableName',
    addVisdiplay:false,
    editDisabled:false
  }, {
    label: '同步至节点组',
    prop: 'nodeGroupId',
  },{
    label: '是否双向同步',
    prop: 'setSymmetric',
    type:'select',
    dicData: DIC.vaild,
  }
  ]
}
