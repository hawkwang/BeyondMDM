/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/index/page',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/index/',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/index/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/index/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/index/',
    method: 'put',
    data: obj
  })
}

export function getAttributes(id) {
  return request({
    url: '/mdm/index/attr/'+ id,
    method: 'get'
  })
}


