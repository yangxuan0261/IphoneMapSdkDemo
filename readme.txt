百度地图iOS LOC-SDK v1.0.0 Sample共有7个Demo,每个Demo的说明如下：

-------------------------------------------------------------------------------------
一、
Demo名称：单次定位功能
文件名：  SingleLocDemoViewController.m

简介：进行单次定位，通过bloc回调位置
详述：
（1）用户配置相关参数，初始化locationmanager；
（2）主动调用requestlocation接口，通过bloc回调相应位置；
（3）定位SDK内部封装了系统的位置功能，单次定位结束后自动停止定位；

-------------------------------------------------------------------------------------
二、
Demo名称：连续定位功能
文件名：  SerialLocDemoViewController.m

简介：进行连续定位，通过delegate不断回调最新位置结果
详述：
（1）用户配置相关参数，初始化locationmanager；
（2）调用start接口，通过delegate回调最新位置

-------------------------------------------------------------------------------------
三、
Demo名称：后台连续定位功能
文件名：  BackgroundLocDemoViewController.m

简介：展示后台连续定位功能
详述：
（1）通过设置allowsBackgroundLocationUpdates = YES 实现后台连续定位功能

-------------------------------------------------------------------------------------
四、
Demo名称：圆形地理围栏功能
文件名：  CircleGeofenceDemoViewController.m

简介：介绍实现圆形地理围栏功能
详述：
（1）设置圆形地理围栏中心点和围栏半径；
（2）监听围栏触发事件；

-------------------------------------------------------------------------------------
五、
Demo名称：多边形地理围栏功能
文件名：  PolyGonGeofenceDemoViewController.m

简介：介绍多边形地理围栏功能
详述：
（1）设置多边形多个顶点；
（2）监听围栏触发事件；

-------------------------------------------------------------------------------------
六、
Demo名称：移动热点识别功能
文件名：  HotSpotDemoViewController.m

简介：介绍移动热点识别功能
详述：
（1）通过delegate回调当前网络状态，识别是否处于移动热点网络环境，减少不必要的下载流量；

-------------------------------------------------------------------------------------
七、
Demo名称：国内外判断功能
文件名：  IsInChinaDemoViewController.mm

简介：通过定位SDK提供的静态方法，实现判断点是否在国内的判断


