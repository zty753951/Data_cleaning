USE [YGDB_C]
GO

/****** Object:  StoredProcedure [dbo].[daily_paper_increment]    Script Date: 2018/10/29 11:15:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

















CREATE  PROCEDURE [dbo].[daily_paper_increment]
AS 

BEGIN
	
	---信审数据源_日报 增量更新

	DECLARE @MAXENTRYTIME DATETIME,--取日报表最大的入库时间
			@NUM_INCREMENT	int

	SELECT  @MAXENTRYTIME=max(ENTRYTIME) FROM [信审数据源_日报]	 --取日报数据源表最大的入库时间

	PRINT '信审数据源_日报 上次更新时间 : '+CONVERT(VARCHAR,@MAXENTRYTIME,120)

	SELECT @NUM_INCREMENT=COUNT(1) FROM [dbo].[信审信息] WHERE ENTRYTIME>@MAXENTRYTIME		--判断信审信息表需要更新的量


	IF @NUM_INCREMENT=0
		
		BEGIN
			PRINT '无数据更新'
		END
	
	ELSE	 
		BEGIN

			PRINT '需更新量为 : '+CONVERT(VARCHAR,@NUM_INCREMENT);

			select  
			门店,
			进件编号,
			进件状态,
			是否加急,
			客服,
			申请金额,
			批复金额,
			申请产品,
			申请期限,
			批复产品,
			进件时间,
			初审人员,
			初审编号,
			初审时间,
			初审结果,
			拒绝原因初审,
			拒绝二级原因初审,
			拒绝三级级原因初审,
			初审备注,
			终审人员,
			终审编号,
			终审时间,
			终审结果,
			[拒绝原因终审],
			[拒绝二级原因终审],
			[拒绝三级级原因终审],
			终审备注,
			反欺诈人员,
			反欺诈时间,
			反欺诈结果,
			拒绝原因反欺诈,
			拒绝子原因反欺诈,
			反欺诈备注,
			质检人员,
			质检结论,
			质检开始时间,
			质检结束时间,
			客户姓名=dbo.EncryptByPassPhrasePwd(客户姓名,'dfyg0001'),
			身份证号码=dbo.EncryptByPassPhrasePwd(身份证号码,'dfyg0002'),
			手机号码=dbo.EncryptByPassPhrasePwd(手机号码,'dfyg0003'),					
			是否已婚,
			户口所在地,
			工资发放形式,
			单位名称,
			单位电话=dbo.EncryptByPassPhrasePwd(单位电话,'dfyg0004'),
			客户职业,
			房产类型,
			补件备注,
			补件原因,
			补件子原因,
			补件时间,
			人行报告来源,
			风险备注,
			风险说明,
			风险建议,
			补件次数,
			批复期限,
			差错性质,
			[质检结论.1],
			差错人员,
			差错类型,
			客户类型,
			备注,
			是否反欺诈规则,

			-----------------------------------绿色字段---------------------------------------------------
			--初审
			[初审人员_G]=(select   top 1 处理人   from 业务操作流程 where 进件编号=a.进件编号 and  环节='审核'  order by 开始时间 desc  ),
			[初审人员工号_G]=(select  top 1  员工编号 from 业务操作流程 where 进件编号=a.进件编号 and  环节='审核' order by 开始时间 desc   ),
			[初审开始时间_G]=(select  top 1 开始时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节='审核'  order by 开始时间 desc  ),
			[初审完成时间_G]=(select  top 1 结束时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节='审核'  order by 开始时间 desc  ),
			--终审	
			[终审人员_G]=(select  top 1 处理人 from 业务操作流程 where 进件编号=a.进件编号 and  环节='复核' order by 开始时间 desc   ),
			[终审人员工号_G]=(select  top 1 员工编号 from 业务操作流程 where 进件编号=a.进件编号 and  环节='复核' order by 开始时间 desc  ),
			[终审开始时间_G]=(select  top 1 开始时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节='复核' order by 开始时间 desc  ),
			[终审完成时间_G]=(select  top 1 结束时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节='复核' order by 开始时间 desc  ),--复议不算终审完成
			--反欺诈
			[反欺诈人员_G]=(select  top 1 处理人 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%反欺诈%' order by 开始时间 desc   ),
			[反欺诈人员工号_G]=(select  top 1 员工编号 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%反欺诈%' order by 开始时间 desc   ),----添加
			[反欺诈开始时间_G]=(select  top 1 开始时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%反欺诈%' order by 开始时间 desc  ),
			[反欺诈完成时间_G]=(select  top 1 结束时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%反欺诈%' order by 开始时间 desc  ),
			--质检
			[质检人员_G]=(select  top 1 处理人 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%质检%'  order by 开始时间 desc  ),
			[质检开始时间_G]=(select  top 1 开始时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%质检%' order by 开始时间 desc  ),
			[质检完成时间_G]=(select  top 1 结束时间 from 业务操作流程 where 进件编号=a.进件编号 and  环节 like '%质检%'  order by 开始时间 desc  ),
			ENTRYTIME
			into #temp
			from    信审信息  a   WITH (NOLOCK)
				where ENTRYTIME>@MAXENTRYTIME ;




			insert into [dbo].[信审数据源_日报]
			select 门店,进件编号,进件状态,是否加急,客服,申请金额,批复金额,申请产品,申请期限,批复产品,进件时间,初审人员,初审编号,初审时间,初审结果,拒绝原因初审,拒绝二级原因初审,拒绝三级级原因初审,初审备注,终审人员,终审编号,终审时间,终审结果,拒绝原因终审,拒绝二级原因终审,拒绝三级级原因终审,终审备注,反欺诈人员,反欺诈时间,反欺诈结果,拒绝原因反欺诈,拒绝子原因反欺诈,反欺诈备注,质检人员,质检结论,质检开始时间,质检结束时间,客户姓名,身份证号码,手机号码,是否已婚,户口所在地,工资发放形式,单位名称,单位电话,客户职业,房产类型,补件备注,补件原因,补件子原因,补件时间,人行报告来源,风险备注,风险说明,风险建议,补件次数,批复期限,差错性质,[质检结论.1],差错人员,差错类型,客户类型,备注,是否反欺诈规则,[初审人员_G],[初审人员工号_G],[初审开始时间_G],[初审完成时间_G],	[终审人员_G],[终审人员工号_G],[终审开始时间_G],[终审完成时间_G],[反欺诈人员_G],[反欺诈人员工号_G], [反欺诈开始时间_G],[反欺诈完成时间_G],[质检人员_G],[质检开始时间_G],[质检完成时间_G]
			,
			-----------------------------------以下为清洗字段---------------------------------------------------
			[进件日期]=convert(varchar(10),进件时间,120),
			[进件时间_R]=convert(varchar(10),进件时间,108),
			[初审完成日期]=convert(varchar(10),[初审完成时间_G],120),
			[终审完成日期]=convert(varchar(10),[终审完成时间_G],120),
			[反欺诈完成日期]=convert(varchar(10),[反欺诈完成时间_G],120),
			[清洗-审批结论]=case when 进件状态='审核中-审核中' and [终审开始时间_G] is null  then '初审处理中'
								 when 进件状态='审核中-审核中' and [终审开始时间_G] is not null  then '终审处理中'
								 when 进件状态='审核结束-同意'  then '批核'
								 when 进件状态 in ('审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝')  then '拒绝'
								 when 进件状态='审核中-补件'  then '补件中'
								 when 进件状态='质检通过'  then '未分配'
								 when 进件状态='审核中-反欺诈审查'  then '反欺诈处理中'	end,
			[案件完成日期]=case when 进件状态 in ('审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝','审核结束-同意') then (select (select Max(NewDate) from (values (convert(varchar(10),[初审完成时间_G],120)),(convert(varchar(10),[终审完成时间_G],120)),(convert(varchar(10),[反欺诈完成时间_G],120))) as #temp(NewDate))  as time from 信审信息 where  进件编号 =aa.进件编号) 	end,
			[批复产品_R]=isnull(批复产品,申请产品),	
			[初审自然日时效]=case when [初审完成时间_G] is not null then datediff(mi,进件时间,[初审完成时间_G]) end ,
			[终审自然日时效]=case when [反欺诈完成时间_G]>[终审完成时间_G] then 0
									   when [终审完成时间_G] is not null then datediff(mi,[初审完成时间_G],[终审完成时间_G]) end, -----？？？
			[初审工作日时效]=case	when convert(varchar(10),[初审完成时间_G],120) is null then 0 
									   when convert(varchar(10),[初审完成时间_G],120) is not null 
									   then 
											datediff(mi,进件时间,[初审完成时间_G])-
											(
											 (select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期 > convert(varchar(10),进件时间,120) and  日期< convert(varchar(10),[初审完成时间_G],120) )
											  -
											 (select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期 > convert(varchar(10),进件时间,120) and  日期< convert(varchar(10),[初审完成时间_G],120) )
											)*60*24		end,
			[终审工作日时效]=case when [反欺诈完成时间_G]>[终审完成时间_G] then 0
									when convert(varchar(10),[终审完成时间_G],120) is null then 0 
									   when convert(varchar(10),[终审完成时间_G],120) is not null 
									   then 
											datediff(mi,[初审完成时间_G],[终审完成时间_G])-
											(
											 (select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期> convert(varchar(10),[初审完成时间_G],120) and 日期< convert(varchar(10),[终审完成时间_G],120) )
											  -
											 (select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期> convert(varchar(10),[初审完成时间_G],120) and 日期< convert(varchar(10),[终审完成时间_G],120) )
											)*60*24		 end,
			[案件完成自然日时效]=case when 进件状态 in ('审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝','审核结束-同意') 
											then datediff(mi,进件时间,(select (select Max(NewDate) from (values ([初审完成时间_G]),([终审完成时间_G]),([反欺诈完成时间_G])) as #temp(NewDate))  as time from 信审信息 where  进件编号 =aa.进件编号) )
									else 0	end,
			[案件完成工作日时效]=case when 进件状态 in ('审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝','审核结束-同意') 
											then 
												datediff(mi,进件时间,(select (select Max(NewDate) from (values ([初审完成时间_G]),([终审完成时间_G]),([反欺诈完成时间_G])) as #temp(NewDate))  as time from 信审信息 where  进件编号 =aa.进件编号) )-
												(
												 (select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期>  convert(varchar(10),进件时间,120) and 日期<(select (select Max(NewDate) from (values (convert(varchar(10),[初审完成时间_G],120)),(convert(varchar(10),[终审完成时间_G],120)),(convert(varchar(10),[反欺诈完成时间_G],120))) as #temp(NewDate))  as time from 信审信息 where  进件编号 =aa.进件编号) )
												  -
												 (select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期> convert(varchar(10),进件时间,120) and  日期<(select (select Max(NewDate) from (values (convert(varchar(10),[初审完成时间_G],120)),(convert(varchar(10),[终审完成时间_G],120)),(convert(varchar(10),[反欺诈完成时间_G],120))) as #temp(NewDate))  as time from 信审信息 where  进件编号 =aa.进件编号)  )
												)*60*24										
											else 0  end,
			[全量是否补件]=case when 补件次数 is not null then  '是'else '否' end ,

			[剔除后是否补件]=case when 补件次数 is not null and (补件子原因 like '%无人行报告%' or 补件子原因 like '%需补充实地征信及实地走访表%' or 补件子原因 like '%风险前置%') then '否'
								  when 补件次数 is not null  then '是' 
							  else 'FALSE'  
							  end ,

			[补件时间_R]= case when 补件时间 is not null then  convert(varchar(10),补件时间,120)  end,
			[是否全案]= case when 进件状态 in ('审核结束-同意','审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝') then '是'	else '否' end,
			[普惠中心]=(select 普惠中心  from [普惠中心门店汇总表] where 门店=aa.门店),
			[分中心]=(select 分中心  from [普惠中心门店汇总表] where 门店=aa.门店),
			[区域]=(select 区域  from [普惠中心门店汇总表] where 门店=aa.门店),
			[管辖地区]=(select 管辖地区  from [普惠中心门店汇总表] where 门店=aa.门店),
			[审批金额]=case when 批复金额 is not  null then  批复金额/10000 end ,
			[超时小时数_DAY]= cast(round(
					datediff(mi,进件时间,(select dbo.[last_work_day](convert(varchar(10),getdate(),120))))/60.0     
			  -
				(
					(select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期>  convert(varchar(10),进件时间,120) and  日期< convert(varchar(10),GETDATE(),120) )
					-
					(select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期>convert(varchar(10),进件时间,120) and   日期< convert(varchar(10),GETDATE(),120) )
				)*24,4) 
				as numeric(12,4)
				),

			[超时小时数_HOUR]= cast(round(
								datediff(mi,进件时间,GETDATE())/60.0
						  -
							(
								(select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期>   convert(varchar(10),进件时间,120) and  日期< convert(varchar(10),GETDATE(),120) )
								-
								(select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期> convert(varchar(10),进件时间,120) and 日期< convert(varchar(10),GETDATE(),120) )
							)*24,4) 
							as numeric(12,4)
							)	,
			[判断是否超时_DAY]=case when (
										cast(round(
												datediff(mi,进件时间,(select dbo.[last_work_day](convert(varchar(10),getdate(),120))))/60.0     
											-
											(
												(select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期>  convert(varchar(10),进件时间,120) and 日期<  convert(varchar(10),GETDATE(),120) )
												-
												(select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期>  convert(varchar(10),进件时间,120) and 日期< convert(varchar(10),GETDATE(),120) )
											)*24,4) 
											as numeric(12,4)
											) > 48  
									)	
									and  
									进件状态 not in ('审核结束-同意','审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝')
								then '是' 
								else '否' end ,
			[判断是否超时_HOUR]=case when (
											cast(round(
													datediff(mi,进件时间,GETDATE())/60
											  -
												(
													(select count(distinct 日期)  from 年度工作安排表 where 类别 in ('双休日','工作日放假日期') and 日期>  convert(varchar(10),进件时间,120) and  日期< convert(varchar(10),GETDATE(),120) )
													-
													(select count(1) from 年度工作安排表 where 类别='周末上班日期' and 日期>  convert(varchar(10),进件时间,120) and 日期< convert(varchar(10),GETDATE(),120) )
												)*24,4) 
												as numeric(12,4)
												) > 48  
									)	
									and  
									进件状态 not in ('审核结束-同意','审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝')
									then '是' 
									else '否' end ,
			[是否未初审(AB)]=case when [初审完成时间_G] is null then '是' else '否' end,
			[是否未终审(AE)]=case when [终审完成时间_G] is null and [反欺诈完成时间_G] is null then '是'  else '否' end,
			[是否分配给初审(AA)]=case when [初审开始时间_G] is null then '否' else '是' end,
			[是否分配给终审(AD)]=case when [终审开始时间_G] is null then '否' else '是' end, 
			[是否提交反欺诈(AG)]=case when  [反欺诈完成时间_G]  is null then '否' else '是' end,
			--[是否积压]=case when 进件状态 in ('审核结束-同意','审核结束-审核拒绝','反欺诈拒绝','审核结束-复议拒绝','风控决策拒绝') then '否' else '是' end,
			[是否积压]=case when 进件状态 in ('审核中-反欺诈审查','审核中-审核中','质检通过') then '是' else '否' end,
			[初审在职人员区域]=(select 地区 from [出勤明细] where 工号=aa.[初审人员工号_G]),
			[终审在职人员区域]=(select 地区 from [出勤明细] where 工号=aa.[终审人员工号_G]),
			[反欺诈在职人员区域]=(select 地区 from [出勤明细] where 工号=aa.[反欺诈人员工号_G]),
			[区域统一]=case when 进件状态='反欺诈拒绝' then  (select 地区 from [出勤明细] where 工号=aa.[反欺诈人员工号_G])
							else (select 地区 from [出勤明细] where 工号=aa.[终审人员工号_G]) end,
			[ENTRYTIME]=ENTRYTIME
			from    #temp  aa ;

			print '日报数据---->更新完成'

			drop table #temp;

			exec('Data_Clean  信审数据源_日报,进件编号');

		END








END




















GO


