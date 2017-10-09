---
layout: post
title: 使用Dom Object 对象和embed标签来展示Pdf文件
category: experience
---

使用object对象来设置pdf文件的加载，兼容IE、Chrome、Firefox。

可以在data属性中设置文件的默认参数，如下文件中所示，来设置pdf阅读的初始状态。代码如下所示：

    <object 
        class="show-resources" 
        type="application/pdf" 
        data="http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf#zoom=96&page=2">
    </object>


<object class="show-resources" type="application/pdf" data="http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf#zoom=96&page=2">
</object>


使用embed标签来设置pdf文件的加载，兼容IE、Chrome、Firefox。

    <embed 
        class="show-resources" 
        src="http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf#zoom=96&page=1">

<embed class="show-resources" src="http://www.adobe.com/content/dam/Adobe/en/devnet/acrobat/pdfs/pdf_open_parameters.pdf#zoom=96&page=2">

