#!/bin/bash
#author wz

#参数提示
if [ $# -lt 3 ];
then
	echo "此脚本可查询mysql配置信息及当前状态信息"
    echo "用法:	sh 脚本名 HOST 用户名 密码"
    exit
fi

echo "############"
echo "#数据库配置#"
echo "############"
#获取数据库配置数据,去掉第一行
res=`mysql -h$1 -u$2 -p$3 -P3306 hh_hnashop -e 'show variables'|awk 'NR>1'`
#转为数组
tmp=($res)
#总数据个数
count=${#tmp[@]}
for(( i=0;i<$count;i=i+1 ))
do
	#echo ${tmp[$i]}
	
	#加入重要的检测指标
	case "`echo ${tmp[$i]}| tr 'A-Z' 'a-z'`" in

		"log_slow_queries")
			log_slow_queries=${tmp[($i+1)]}
			echo "慢查询日志:"${tmp[($i+1)]}
		;;
        "slow_launch_threads")
				slow_launch_threads=${tmp[($i+1)]}
                echo "查询日志的查询阀值:"${tmp[($i+1)]}
        ;;
		"max_connections")
			max_connections=${tmp[($i+1)]}
			echo "最大连接数是:"${tmp[($i+1)]}
		;;	
		"key_buffer_size")
			key_buffer_size=${tmp[($i+1)]}
			echo "内存分配数:"${tmp[($i+1)]}
		;;
		"max_heap_table_size")
			max_heap_table_size=${tmp[($i+1)]}
			echo "最大可调入内存表尺寸:"${tmp[($i+1)]}
		;;	
		"tmp_table_size")
			tmp_table_size=${tmp[($i+1)]}
			echo "最大临时表尺寸:"${tmp[($i+1)]}
		;;	
		"table_open_cache")
			table_open_cache=${tmp[($i+1)]}
			echo "表缓存数量:"${tmp[($i+1)]}
		;;
		"thread_cache_size")
			thread_cache_size=${tmp[($i+1)]}
			echo "线程缓存数量:"${tmp[($i+1)]}
		;;
		
		"query_cache_limit")
			query_cache_limit=${tmp[($i+1)]}
			echo "查询缓存最大数:"${tmp[($i+1)]}
		;;
		"query_cache_min_res_unit")
			query_cache_min_res_unit=${tmp[($i+1)]}
			echo "缓存块的最小大小:"${tmp[($i+1)]}
		;;	
		"query_cache_size")
			query_cache_size=${tmp[($i+1)]}
			echo "查询缓存大小:"${tmp[($i+1)]}
		;;	
		"query_cache_type")
			query_cache_type=${tmp[($i+1)]}
			echo "缓存类型:"${tmp[($i+1)]}
		;;
		"query_cache_wlock_invalidate")
			query_cache_wlock_invalidate=${tmp[($i+1)]}
			echo "当有其他客户端正在对myisam表进行写操作时，如果查询在query cache中，是否返回cache结果还是等写操作完成再读表获取结果:"${tmp[($i+1)]}
		;;	
		"open_files_limit")
			open_files_limit=${tmp[($i+1)]}
			echo "打开的文件最大数量:"${tmp[($i+1)]}
		;;
	esac
done
echo ""
echo "##########################"
echo "#以下为当前数据库状态信息#"
echo "##########################"
#获取数据库状态数据,去掉第一行
res=`mysql  -h$1 -u$2 -p$3 -P3306 hh_hnashop -e 'show global status'|awk 'NR>1'`
#转为数组
tmp=($res)
#总数据个数
count=${#tmp[@]}
for(( i=0;i<$count;i=i+1 ))
do
	#echo ${tmp[$i]}
	
	#加入重要的检测指标
	case "`echo ${tmp[$i]}| tr 'A-Z' 'a-z'`" in

		"max_used_connections")
			max_used_connections=${tmp[($i+1)]}
			echo "历史最大连接数:"${tmp[($i+1)]}
		;;

        "slow_launch_threads")
                echo "线程超时数:"${tmp[($i+1)]}
        ;;

        "slow_queries")
                echo "慢查询数:"${tmp[($i+1)]}
        ;;

        "key_read_requests")
				key_read_requests=${tmp[($i+1)]}
                echo "索引读取请求数:"${tmp[($i+1)]}
        ;;

        "key_reads")
				key_reads=${tmp[($i+1)]}
                echo "内存中没有找到直接从硬盘读取索引数:"${tmp[($i+1)]}
        ;;

        "key_blocks_unused")
				key_blocks_unused=${tmp[($i+1)]}
                echo "未使用的缓存簇数:"${tmp[($i+1)]}
        ;;

        "key_blocks_used")
				key_blocks_used=${tmp[($i+1)]}
                echo "曾经用到的最大的缓存簇数:"${tmp[($i+1)]}
        ;;

        "created_tmp_disk_tables")
                created_tmp_disk_tables=${tmp[($i+1)]}
                echo "创建临时磁盘表数:"${tmp[($i+1)]}
        ;;

        "created_tmp_files")
                created_tmp_files=${tmp[($i+1)]}
                echo "创建临时文件数:"${tmp[($i+1)]}
        ;;
        
        "created_tmp_tables")
                created_tmp_tables=${tmp[($i+1)]}
                echo "创建临时表数:"${tmp[($i+1)]}
        ;;

		"open_tables")
			open_tables=${tmp[($i+1)]}
			echo "打开的表数:"${tmp[($i+1)]}
		;;

		"opened_tables")
			opened_tables=${tmp[($i+1)]}
			echo "打开过的表数:"${tmp[($i+1)]}
		;;

		"threads_cached")
			threads_cached=${tmp[($i+1)]}
			echo "线程缓存数数:"${tmp[($i+1)]}
		;;

		"threads_connected")
			threads_connected=${tmp[($i+1)]}
			echo "已经建立的连接数:"${tmp[($i+1)]}
		;;

		"threads_created")
			threads_created=${tmp[($i+1)]}
			echo "创建过的线程数:"${tmp[($i+1)]}
		;;

		"threads_running")
			threads_running=${tmp[($i+1)]}
			echo "运行的线程数:"${tmp[($i+1)]}
		;;
		
		"qcache_free_blocks")
			qcache_free_blocks=${tmp[($i+1)]}
			echo "缓存中相邻内存块的个数[数目大说明可能有碎片]:"${tmp[($i+1)]}
		;;

		"qcache_free_memory")
			qcache_free_memory=${tmp[($i+1)]}
			echo "缓存中的空闲内存:"${tmp[($i+1)]}
		;;	

		"qcache_hits")
			qcache_hits=${tmp[($i+1)]}
			echo "缓存命中数:"${tmp[($i+1)]}
		;;	
		
		"qcache_inserts")
			qcache_inserts=${tmp[($i+1)]}
			echo "缓存插入数:"${tmp[($i+1)]}
		;;

		"qcache_lowmem_prunes")
			qcache_lowmem_prunes=${tmp[($i+1)]}
			echo "缓存不足必须要进行清理:"${tmp[($i+1)]}
		;;	

		"qcache_not_cached")
			qcache_not_cached=${tmp[($i+1)]}
			echo "不适合进行缓存的查询的数量[通常是由于这些查询不是 select 语句或者用了now()之类的函数]:"${tmp[($i+1)]}
		;;			
		
		"qcache_queries_in_cache")
			qcache_queries_in_cache=${tmp[($i+1)]}
			echo "当前缓存的查询（和响应）的数:"${tmp[($i+1)]}
		;;

		"qcache_total_blocks")
			qcache_total_blocks=${tmp[($i+1)]}
			echo "缓存中块的数量:"${tmp[($i+1)]}
		;;			
		
		"sort_merge_passes")
			sort_merge_passes=${tmp[($i+1)]}
			echo "排序借助内存临时文件再次排序次数:"${tmp[($i+1)]}
		;;

		"sort_range")
			sort_range=${tmp[($i+1)]}
			echo "排序通过范围查找次数:"${tmp[($i+1)]}
		;;	

		"sort_rows")
			sort_rows=${tmp[($i+1)]}
			echo "排序影响的总记录数:"${tmp[($i+1)]}
		;;			
		
		"sort_scan")
			sort_scan=${tmp[($i+1)]}
			echo "排序使用全盘扫描次数:"${tmp[($i+1)]}
		;;

		"open_files")
			open_files=${tmp[($i+1)]}
			echo "文件打开数:"${tmp[($i+1)]}
		;;		
		
		"table_locks_immediate")
			table_locks_immediate=${tmp[($i+1)]}
			echo "表锁立即释放数:"${tmp[($i+1)]}
		;;

		"table_locks_waited")
			table_locks_waited=${tmp[($i+1)]}
			echo "表锁需要等待数:"${tmp[($i+1)]}
		;;		

		"handler_read_first")
			handler_read_first=${tmp[($i+1)]}
			echo "读取索引第一个条目的次数:"${tmp[($i+1)]}
		;;

		"handler_read_last")
			handler_read_last=${tmp[($i+1)]}
			echo "读取索引最后一个条目的次数:"${tmp[($i+1)]}
		;;	

		"handler_read_next")
			handler_read_next=${tmp[($i+1)]}
			echo "通过索引读取下一条数据的次数:"${tmp[($i+1)]}
		;;			
		
		"handler_read_prev")
			handler_read_prev=${tmp[($i+1)]}
			echo "通过索引读取上一条数据的次数:"${tmp[($i+1)]}
		;;

		"handler_read_rnd")
			handler_read_rnd=${tmp[($i+1)]}
			echo "从固定位置读取数据的次数:"${tmp[($i+1)]}
		;;		
		
		"handler_read_rnd_next")
			handler_read_rnd_next=${tmp[($i+1)]}
			echo "从数据节点读取读取下一条数据的次数:"${tmp[($i+1)]}
		;;

		"handler_read_key")
			handler_read_key=${tmp[($i+1)]}
			echo "通过index获取数据的次数:"${tmp[($i+1)]}
		;;	

		"com_select")
			com_select=${tmp[($i+1)]}
			echo "select语句执行次数:"${tmp[($i+1)]}
		;;			
	esac
done
echo ""
echo "服务器连接率[历史最大连接数/配置最大连接数][85%比较合适][10%以下，服务器连接数上限设置的过高了]:" `awk 'BEGIN{printf "%.3f%%\n",('$max_used_connections'/'$max_connections')*100}'`
echo ""
echo "索引未命中缓存的概率[硬盘读取索引数/索引读取请求数][在0.1%以下都OK][0.01%以下的话，key_buffer_size分配的过多，可以适当减少]:" `awk 'BEGIN{printf "%.3f%%\n",('$key_reads'/'$key_read_requests')*100}'`
echo ""
echo "缓存簇使用率[曾用最大的缓存簇数/（曾用最大的缓存簇数+未使用的）][80%为比较合理]:" `awk 'BEGIN{printf "%.3f%%\n",( '$key_blocks_used' / ('$key_blocks_used' + '$key_blocks_unused'))*100}'`
echo ""
if [ "$qcache_free_blocks" -gt 0 ]; then
echo "查询缓存碎片率[缓存中相邻内存块的个数/缓存中块的数量][如果查询缓存碎片率超过20%，可以用flush query cache整理缓存碎片]:" `awk 'BEGIN{printf "%.3f%%\n",( '$qcache_free_blocks' / '$qcache_total_blocks')*100}'`
echo ""
echo "查询缓存利用率[查询缓存利用率在25%以下的话说明query_cache_size设置的过大，可适当减小；查询缓存利用率在80％以上而且qcache_lowmem_prunes > 50的话说明query_cache_size可能有点小，要不就是碎片太多]:" `awk 'BEGIN{printf "%.3f%%\n",( ('$query_cache_size' - $qcache_free_memory) / '$query_cache_size')*100}'`
echo ""
echo "查询缓存命中率:" `awk 'BEGIN{printf "%.3f%%\n",( ('$qcache_hits' - $qcache_inserts) / '$qcache_hits')*100}'`
echo ""
fi
echo "创建磁盘表率[创建临时磁盘表数/创建临时表数][<=25%为比较合理]:" `awk 'BEGIN{printf "%.3f%%\n",( '$created_tmp_disk_tables' / '$created_tmp_tables' )*100}'`
echo ""
echo "打开的表率[打开的表数/打开过的表数][>=85%为比较合理]:" `awk 'BEGIN{printf "%.3f%%\n",( '$open_tables' / '$opened_tables' )*100}'`
echo ""
echo "打开的表缓存率[打开的表数/表缓存数量配置][<=95%为比较合理]:" `awk 'BEGIN{printf "%.3f%%\n",( '$open_tables' / '$table_open_cache' )*100}'`
echo ""
echo "扫表率[从数据节点读取读取下一条数据的次数/select执行次数][<=4000比较合理][超过4000，表扫描太多，索引没有建好，增加read_buffer_size会好些，但不要超过8mb]:" `awk 'BEGIN{printf "%d\n",( '$handler_read_rnd_next' / '$com_select' )}'`
