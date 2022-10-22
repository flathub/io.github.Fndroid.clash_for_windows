#!/bin/bash
#
# /app/bin/migrate_checker.sh

WARN1="Flathub对宿主机文件系统访问权限做出了限制，现在Clash for Windows无法访问原先的配置文件。\n\
请在终端执行以下命令以将配置文件移动到Clash for Windows可以访问的位置：\n\
\n\
mkdir -p ~/.var/app/io.github.Fndroid.clash_for_windows/.config &amp;&amp; \\\\\n\
rmdir ~/.var/app/io.github.Fndroid.clash_for_windows/config/clash &amp;&amp; \\\\\n\
mv -t ~/.var/app/io.github.Fndroid.clash_for_windows/.config ~/.config/clash\n"
WARN2="\n如果你已经执行了上述命令并且重启了Clash for Windows但不起效，请执行以下命令：\n\n\
mv -t ~/.config ~/.var/app/io.github.Fndroid.clash_for_windows/.config/clash &amp;&amp; \\\\\n\
rm -rf ~/.var/app/io.github.Fndroid.clash_for_windows &amp;&amp; \\\\\n\
mkdir -p ~/.var/app/io.github.Fndroid.clash_for_windows/.config &amp;&amp; \\\\\n\
mv -t ~/.var/app/io.github.Fndroid.clash_for_windows/.config ~/.config/clash\n"
WARN3="\n然后重新启动Clash for Windows。"


if [ -f $XDG_CONFIG_HOME/new_install_0 ]; then
    ## 没有从旧版升级，不需要考虑迁移策略
    exit 0
fi

if [[ -d $XDG_CONFIG_HOME/clash_win ]]; then
    # CFW已经运行过
    if [ -z "$(ls -A ~/.config/clash)" ]; then
        ## $XDG_CONFIG_HOME/clash 目录为空，说明未迁移数据

        if [ -f $XDG_CONFIG_HOME/error_migrate ]; then
            ## 已经弹出过一次对话框，则追加说明
            zenity --error --text="$WARN1$WARN2$WARN3"
        else
            touch $XDG_CONFIG_HOME/error_migrate >> /dev/null 2>&1
            zenity --error --text="$WARN1$WARN3"
        fi
        exit 1 ## 因为cfw.sh有`set -e`，这里返回非0值使其不继续运行CFW主程序
    fi
fi
## 正常状态
touch $XDG_CONFIG_HOME/new_install_0 >> /dev/null 2>&1
exit 0
