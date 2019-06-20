/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/rule/page',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/rule/',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/rule/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/rule/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/rule/',
    method: 'put',
    data: obj
  })
}


