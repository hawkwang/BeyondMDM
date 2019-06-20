/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/entitySync/list',
    method: 'get',
    params: query
  })
}
export function tableSync(obj){
  return request({
    url: '/mdm/entitySync/execSync?id='+obj.id,
    method: 'post'
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/entitySync/add',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/entity/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/entitySync/delete/' + row.id ,
    method: 'get'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/entity/',
    method: 'put',
    data: obj
  })
}


