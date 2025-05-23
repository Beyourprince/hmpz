import request from './request'

export interface return_order_type {
  serviceImg: string
  service_name: string
  hospital_name: string
  starttime: string
  trade_state: string
  order_start_time: number
  out_trade_no: string
}

interface order_type {
  state: number
}

export function getOrderList(data: order_type) {
  return request<Array<return_order_type>>({
    url: "/order/list",
    method: "get",
    data
  })

}