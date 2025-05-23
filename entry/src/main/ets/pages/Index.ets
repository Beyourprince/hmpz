import home from './home'
import { router } from '@kit.ArkUI'
import orders from './orders'

interface params {
  index: number
}

@Entry
@Component
struct Index {
  TabsController: TabsController = new TabsController()

  onPageShow(): void {
    if (router.getParams()) {
      let index = (router.getParams() as params).index
      this.TabsController.changeIndex(index)
    }
  }

  build() {
    Tabs({ index: 1, barPosition: BarPosition.End, controller: this.TabsController }) {
      TabContent() {
        home()
      }.tabBar(
        '首页'
      )

      TabContent() {
        orders().height('100%')
      }.tabBar(
        '订单'
      )

      TabContent() {
      }.tabBar(
        '我的'
      )
    }
  }
}