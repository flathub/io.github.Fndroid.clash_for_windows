#!/bin/bash
#
# /app/bin/migrate_checker.sh

if [[ -d $XDG_CONFIG_HOME/clash_win ]]; then
    # CFW已经运行过
    if [ -z "$(ls -A ~/.config/clash)" ]; then
        ## $XDG_CONFIG_HOME/clash 目录为空，说明未迁移数据
        echo "Flathub对宿主机文件系统访问权限做出了限制，现在Clash for Windows无法访问原先的配置文件。"
        echo "请在终端执行以下命令以将配置文件移动到Clash for Windows可以访问的位置："
        echo
        echo "mkdir -p ~/.var/app/io.github.Fndroid.clash_for_windows/.config && \\"
        echo "rmdir ~/.var/app/io.github.Fndroid.clash_for_windows/config/clash && \\"
        echo "mv -t ~/.var/app/io.github.Fndroid.clash_for_windows/.config ~/.config/clash"
        if [ -f $XDG_CONFIG_HOME/error_migrate ]; then
            echo
            echo "如果你已经执行了上述命令并且重启了Clash for Windows但不起效，请执行以下命令："
            echo
            echo "mv -t ~/.config ~/.var/app/io.github.Fndroid.clash_for_windows/.config/clash && \\"
            echo "rm -rf ~/.var/app/io.github.Fndroid.clash_for_windows && \\"
            echo "mkdir -p ~/.var/app/io.github.Fndroid.clash_for_windows/.config && \\"
            echo "mv -t ~/.var/app/io.github.Fndroid.clash_for_windows/.config ~/.config/clash"
        else
            touch $XDG_CONFIG_HOME/error_migrate >> /dev/null 2>&1
        fi
        echo
        echo "然后重新启动Clash for Windows。"
        echo
        read -n 1 -s -r -p "按下任意键关闭Clash for Windows"; echo
        pkill cfw
        pkill clash-linux
        return 1
    else
        return 0
    fi
fi

