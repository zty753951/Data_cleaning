USE [YGDB_C]
GO

/****** Object:  StoredProcedure [dbo].[Data_Clean]    Script Date: 2018/10/29 11:14:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE  PROCEDURE [dbo].[Data_Clean](@TABLENAME VARCHAR(50),@COLUMN VARCHAR(50)) 
	
AS


--'贷后','进件编号'
--'客户经理和团队经理进件数据','order_num'
--'运营','进件编号'
--'信审信息','进件编号'
--'业务操作流程','进件编号,环节,开始时间'





DECLARE @sqltext_Clean NVARCHAR(MAX)
SET @sqltext_Clean=('
					;with tmp as (
					SELECT '+@COLUMN+',rn=ROW_NUMBER() over (partition by '+@COLUMN+' order by ENTRYTIME DESC ) 
					FROM '+@TABLENAME+' with(nolock)'+'
					)
					delete from tmp where rn>1'
					)

print @sqltext_Clean

IF @TABLENAME='信审信息'	--[信审信息]表单独做特殊处理
	BEGIN
			BEGIN							
				---更新之前去重、加标记处理 Is_valid为0 为未处理，Is_valid为1为已处理
				insert into [信审信息]
								select  distinct 
						门店,进件编号,进件状态,是否加急,客服,申请金额,批复金额,申请产品,申请期限,批复产品,进件时间,初审人员,初审编号,初审时间,初审结果,拒绝原因初审,拒绝二级原因初审,拒绝三级级原因初审,初审备注,终审人员,终审编号,终审时间,终审结果,拒绝原因终审,拒绝二级原因终审,拒绝三级级原因终审,终审备注,反欺诈人员,反欺诈时间,反欺诈结果,拒绝原因反欺诈,拒绝子原因反欺诈,反欺诈备注,质检人员,质检结论,质检开始时间,质检结束时间,客户姓名,身份证号码,手机号码,是否已婚,户口所在地,工资发放形式,单位名称,单位电话,客户职业,房产类型,
					补件备注=(select distinct 补件备注+'|**|' from [信审信息] where 进件编号=T.进件编号 and Is_valid=0   for xml path('')),
					补件原因=(select distinct 补件原因+'|**|' from [信审信息] where 进件编号=T.进件编号  and Is_valid=0 for xml path('')),
					补件子原因=(select distinct 补件子原因+'|**|' from [信审信息] where 进件编号=T.进件编号  and Is_valid=0   for xml path('') ),
					补件时间=(select top 1 补件时间 from [信审信息]  where 进件编号=T.进件编号 order by 补件时间 desc ),
					人行报告来源,风险备注,风险说明,风险建议,补件次数,批复期限,
					差错性质=(select top 1 差错性质 from [信审信息] where 进件编号=T.进件编号 order by 差错性质 desc),
					[质检结论.1]=(select top 1  [质检结论.1] from [信审信息] where 进件编号=T.进件编号 order by case [质检结论.1] when '异常' then 1 else 2 end asc  ),
					差错人员=(select top 1 差错人员 from [信审信息] where 进件编号=T.进件编号 order by 差错人员 desc),
					差错类型=(select top 1 差错类型 from [信审信息] where 进件编号=T.进件编号 order by 差错类型 desc),
					客户类型,备注,是否反欺诈规则,
					ENTRYTIME=GETDATE(),
					Is_valid=1			
					from  [信审信息]   T where Is_valid=0
			END
			

			BEGIN
				EXEC('DELETE FROM 信审信息 where Is_valid=0')		--删除Is_valid为0的
			END 
		

			BEGIN 
				EXEC(@sqltext_Clean)								--更新清洗数据
				PRINT @TABLENAME+'---->数据清洗已完成'
			END 		

			--BEGIN
			--	IF datepart( Hour ,GETDATE() )<9
			--			BEGIN
			--				EXEC('TRUNCATE TABLE 信审数据源_日报')
			--				EXEC('INSERT INTO 信审数据源_日报 SELECT * FROM datasource_xinshen_day')
			--			END
				
				--ELSE
				--		BEGIN
				--			EXEC('TRUNCATE TABLE 信审数据源_时报')
				--			EXEC('INSERT INTO 信审数据源_时报 SELECT * FROM datasource_xinshen_hour')
				--		END

			--END


	END





ELSE	

	BEGIN

		EXEC(@sqltext_Clean)								--更新清洗数据
		PRINT @TABLENAME+'---->数据清洗已完成'

	END















GO


