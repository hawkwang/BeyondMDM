/**
 * 实体api
 */

import request from '@/router/axios'

export function fetchList (query) {
  return request({
    url: '/mdm/attribute/page',
    method: 'get',
    params: query
  })
}

export function addObj (obj) {
  return request({
    url: '/mdm/attribute/',
    method: 'post',
    data: obj
  })
}

export function getObj (id) {
  return request({
    url: '/mdm/attribute/' + id,
    method: 'get'
  })
}

export function delObj (row) {
  return request({
    url: '/mdm/attribute/' + row.id ,
    method: 'delete'
  })
}

export function putObj (obj) {
  return request({
    url: '/mdm/attribute/',
    method: 'put',
    data: obj
  })
}


