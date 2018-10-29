USE [YGDB_C]
GO

/****** Object:  StoredProcedure [dbo].[Data_Clean]    Script Date: 2018/10/29 11:14:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE  PROCEDURE [dbo].[Data_Clean](@TABLENAME VARCHAR(50),@COLUMN VARCHAR(50)) 
	
AS


--'����','�������'
--'�ͻ�������ŶӾ����������','order_num'
--'��Ӫ','�������'
--'������Ϣ','�������'
--'ҵ���������','�������,����,��ʼʱ��'





DECLARE @sqltext_Clean NVARCHAR(MAX)
SET @sqltext_Clean=('
					;with tmp as (
					SELECT '+@COLUMN+',rn=ROW_NUMBER() over (partition by '+@COLUMN+' order by ENTRYTIME DESC ) 
					FROM '+@TABLENAME+' with(nolock)'+'
					)
					delete from tmp where rn>1'
					)

print @sqltext_Clean

IF @TABLENAME='������Ϣ'	--[������Ϣ]���������⴦��
	BEGIN
			BEGIN							
				---����֮ǰȥ�ء��ӱ�Ǵ��� Is_validΪ0 Ϊδ����Is_validΪ1Ϊ�Ѵ���
				insert into [������Ϣ]
								select  distinct 
						�ŵ�,�������,����״̬,�Ƿ�Ӽ�,�ͷ�,������,�������,�����Ʒ,��������,������Ʒ,����ʱ��,������Ա,������,����ʱ��,������,�ܾ�ԭ�����,�ܾ�����ԭ�����,�ܾ�������ԭ�����,����ע,������Ա,������,����ʱ��,������,�ܾ�ԭ������,�ܾ�����ԭ������,�ܾ�������ԭ������,����ע,����թ��Ա,����թʱ��,����թ���,�ܾ�ԭ����թ,�ܾ���ԭ����թ,����թ��ע,�ʼ���Ա,�ʼ����,�ʼ쿪ʼʱ��,�ʼ����ʱ��,�ͻ�����,���֤����,�ֻ�����,�Ƿ��ѻ�,�������ڵ�,���ʷ�����ʽ,��λ����,��λ�绰,�ͻ�ְҵ,��������,
					������ע=(select distinct ������ע+'|**|' from [������Ϣ] where �������=T.������� and Is_valid=0   for xml path('')),
					����ԭ��=(select distinct ����ԭ��+'|**|' from [������Ϣ] where �������=T.�������  and Is_valid=0 for xml path('')),
					������ԭ��=(select distinct ������ԭ��+'|**|' from [������Ϣ] where �������=T.�������  and Is_valid=0   for xml path('') ),
					����ʱ��=(select top 1 ����ʱ�� from [������Ϣ]  where �������=T.������� order by ����ʱ�� desc ),
					���б�����Դ,���ձ�ע,����˵��,���ս���,��������,��������,
					�������=(select top 1 ������� from [������Ϣ] where �������=T.������� order by ������� desc),
					[�ʼ����.1]=(select top 1  [�ʼ����.1] from [������Ϣ] where �������=T.������� order by case [�ʼ����.1] when '�쳣' then 1 else 2 end asc  ),
					�����Ա=(select top 1 �����Ա from [������Ϣ] where �������=T.������� order by �����Ա desc),
					�������=(select top 1 ������� from [������Ϣ] where �������=T.������� order by ������� desc),
					�ͻ�����,��ע,�Ƿ���թ����,
					ENTRYTIME=GETDATE(),
					Is_valid=1			
					from  [������Ϣ]   T where Is_valid=0
			END
			

			BEGIN
				EXEC('DELETE FROM ������Ϣ where Is_valid=0')		--ɾ��Is_validΪ0��
			END 
		

			BEGIN 
				EXEC(@sqltext_Clean)								--������ϴ����
				PRINT @TABLENAME+'---->������ϴ�����'
			END 		

			--BEGIN
			--	IF datepart( Hour ,GETDATE() )<9
			--			BEGIN
			--				EXEC('TRUNCATE TABLE ��������Դ_�ձ�')
			--				EXEC('INSERT INTO ��������Դ_�ձ� SELECT * FROM datasource_xinshen_day')
			--			END
				
				--ELSE
				--		BEGIN
				--			EXEC('TRUNCATE TABLE ��������Դ_ʱ��')
				--			EXEC('INSERT INTO ��������Դ_ʱ�� SELECT * FROM datasource_xinshen_hour')
				--		END

			--END


	END





ELSE	

	BEGIN

		EXEC(@sqltext_Clean)								--������ϴ����
		PRINT @TABLENAME+'---->������ϴ�����'

	END















GO


