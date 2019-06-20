/**
 * 请求数据管理api
 */
import request from '@/router/axios'

//获实体的字段属性,若为空字符串，则选择第一个为默认实体
export function getOptions(entityId) {
  return request({
    url: '/mdm/resource/attrDict/'+entityId,
    method: 'get',
    params: entityId
  })
}

//获取实体数据列表
export function getResourceList(query){
  return request({
    url: '/mdm/resource/list',
    method: 'post',
    data: query
  })
}


//更新实体数据
export function updateResource(obj){
  return request({
    url: '/mdm/resource/update',
    method: 'put',
    data: obj
  })
}


//添加实体数据
export function addResource(obj){
  return request({
    url: '/mdm/resource/add/',
    method: 'post',
    data: obj
  })
}

//删除实体数据
export function delResource(obj) {
  return request({
    url: '/mdm/resource/del',
    method: 'post',
    data:obj
  })
}
