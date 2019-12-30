{%- if theme.footer.beian.enable %}
  <div class="beian">
    {{- next_url('http://www.beian.miit.gov.cn', theme.footer.beian.icp + ' ') }}
    {%- if theme.footer.beian.gongan_icon_url %}
      <img src="{{ theme.footer.beian.gongan_icon_url }}" style="display: inline-block;">
    {%- endif %}
    {%- if theme.footer.beian.gongan_id and theme.footer.beian.gongan_num %}
      {{- next_url('http://www.beian.gov.cn/portal/registerSystemInfo?recordcode=' + theme.footer.beian.gongan_id, theme.footer.beian.gongan_num + ' ') }}
    {%- endif %}
  </div>
{%- endif %}

  <!--busuanzi-->
  <script async src="https://busuanzi.ibruce.info/busuanzi/2.3/busuanzi.pure.mini.js"></script>

<div class="copyright">

  <!--jump-->
  <a href="/" id="jump" class="fa fa-yelp"></a>

  <!--author-->

  <span class="author" itemprop="copyrightHolder">&nbsp{{ theme.footer.copyright or author }}</span>
 
  <!--加入小站运行天数-->
  <span id="timeDate">载入天数...</span><span id="times">载入时分秒...</span>
  <script>
      var now = new Date(); 
      function createtime() { 
          var grt= new Date("10/01/2019 8:00:00"); //在此处修改你的建站时间
          now.setTime(now.getTime()+250); 
          days = (now - grt ) / 1000 / 60 / 60 / 24; dnum = Math.floor(days); 
          hours = (now - grt ) / 1000 / 60 / 60 - (24 * dnum); hnum = Math.floor(hours); 
          if(String(hnum).length ==1 ){hnum = "0" + hnum;} minutes = (now - grt ) / 1000 /60 - (24 * 60 * dnum) - (60 * hnum); 
          mnum = Math.floor(minutes); if(String(mnum).length ==1 ){mnum = "0" + mnum;} 
          seconds = (now - grt ) / 1000 - (24 * 60 * 60 * dnum) - (60 * 60 * hnum) - (60 * mnum); 
          snum = Math.round(seconds); if(String(snum).length ==1 ){snum = "0" + snum;} 
          document.getElementById("timeDate").innerHTML = " Runing "+dnum+" 天 "; 
          document.getElementById("times").innerHTML = hnum + " 时 " + mnum + " 分 " + snum + " 秒"; 
      } 
  setInterval("createtime()",250);
  </script>

  </br>
  <i class="fa fa-gg">&nbsp小站</i>
  <!--UV-->
  <span id="busuanzi_container_site_uv">
    总访客数：<span id="busuanzi_value_site_uv"></span>&nbsp人
  </span>
  <!--PV-->
  <span id="busuanzi_container_site_pv">
    ||&nbsp
  <i class="fa fa-gg">&nbsp小站</i>总访问量：<span id="busuanzi_value_site_pv"></span>&nbsp次
  </span>

</div>

  {%- if config.symbols_count_time.total_symbols %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-area-chart"></i>
    </span>
    {%- if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.count_total') + __('symbol.colon') }}</span>
    {%- endif %}
    <span title="{{ __('symbols_count_time.count_total') }}">{{ symbolsCountTotal(site) }}</span>
  {%- endif %}

  {%- if config.symbols_count_time.total_time %}
    <span class="post-meta-divider">|</span>
    <span class="post-meta-item-icon">
      <i class="fa fa-coffee"></i>
    </span>
    {%- if theme.symbols_count_time.item_text_total %}
      <span class="post-meta-item-text">{{ __('symbols_count_time.time_total') }} &asymp;</span>
    {%- endif %}
    <span title="{{ __('symbols_count_time.time_total') }}">{{ symbolsTimeTotal(site, theme.symbols_count_time.awl, theme.symbols_count_time.wpm, __('symbols_count_time.time_minutes')) }}</span>
  {%- endif %}
</div>

<!--
{%- if theme.footer.powered.enable %}
  
   <div class="powered-by">
    {{- __('footer.powered', next_url('https://hexo.io', 'Hexo', {class: 'theme-link'})) }}
    {%- if theme.footer.powered.version %} v{{ hexo_version }}{%- endif %}
  </div>
{%- endif %}

{%- if theme.footer.powered.enable and theme.footer.theme.enable %}
  <span class="post-meta-divider">|</span>
{%- endif %}

{%- if theme.footer.theme.enable %}
 
  <div class="theme-info">
    {%- set next_site = 'https://theme-next.org' %}
    {%- if theme.scheme !== 'Gemini' %}
      {%- set next_site = 'https://' + theme.scheme | lower + '.theme-next.org' %}
    {%- endif %}
    {{- __('footer.theme') }} – {{ next_url(next_site, 'NexT.' + theme.scheme, {class: 'theme-link'}) }}
    {%- if theme.footer.theme.version %} v{{ next_version }}{%- endif %}
  </div>
 
{%- endif %}
   -->
{%- if theme.add_this_id %}
  <div class="addthis_inline_share_toolbox">
    <script src="//s7.addthis.com/js/300/addthis_widget.js#pubid={{ theme.add_this_id }}" async="async"></script>
  </div>
{%- endif %}

{{- next_inject('footer') }}

