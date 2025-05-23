import orderList from "../component/orderList"

@Component
struct orders {
  tabList: Array<string> = ["全部", "待支付", "待服务", "已完成", "已取消"]

  build() {
    Column() {
      Text('我的订单')
      Tabs() {
        ForEach(this.tabList, (item: string, index: number) => {
          TabContent() {
            orderList({
              state: index
            }).height('100%')
          }.tabBar(item)
        })
      }
    }
  }
}

export default orders