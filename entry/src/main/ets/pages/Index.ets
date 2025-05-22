import home from './home'
import { router } from '@kit.ArkUI'

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
    Tabs({ barPosition: BarPosition.End, controller: this.TabsController }) {
      TabContent() {
        home()
      }.tabBar(
        '首页'
      )

      TabContent() {
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