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
	
	---��������Դ_�ձ� ��������

	DECLARE @MAXENTRYTIME DATETIME,--ȡ�ձ����������ʱ��
			@NUM_INCREMENT	int

	SELECT  @MAXENTRYTIME=max(ENTRYTIME) FROM [��������Դ_�ձ�]	 --ȡ�ձ�����Դ���������ʱ��

	PRINT '��������Դ_�ձ� �ϴθ���ʱ�� : '+CONVERT(VARCHAR,@MAXENTRYTIME,120)

	SELECT @NUM_INCREMENT=COUNT(1) FROM [dbo].[������Ϣ] WHERE ENTRYTIME>@MAXENTRYTIME		--�ж�������Ϣ����Ҫ���µ���


	IF @NUM_INCREMENT=0
		
		BEGIN
			PRINT '�����ݸ���'
		END
	
	ELSE	 
		BEGIN

			PRINT '�������Ϊ : '+CONVERT(VARCHAR,@NUM_INCREMENT);

			select  
			�ŵ�,
			�������,
			����״̬,
			�Ƿ�Ӽ�,
			�ͷ�,
			������,
			�������,
			�����Ʒ,
			��������,
			������Ʒ,
			����ʱ��,
			������Ա,
			������,
			����ʱ��,
			������,
			�ܾ�ԭ�����,
			�ܾ�����ԭ�����,
			�ܾ�������ԭ�����,
			����ע,
			������Ա,
			������,
			����ʱ��,
			������,
			[�ܾ�ԭ������],
			[�ܾ�����ԭ������],
			[�ܾ�������ԭ������],
			����ע,
			����թ��Ա,
			����թʱ��,
			����թ���,
			�ܾ�ԭ����թ,
			�ܾ���ԭ����թ,
			����թ��ע,
			�ʼ���Ա,
			�ʼ����,
			�ʼ쿪ʼʱ��,
			�ʼ����ʱ��,
			�ͻ�����=dbo.EncryptByPassPhrasePwd(�ͻ�����,'dfyg0001'),
			���֤����=dbo.EncryptByPassPhrasePwd(���֤����,'dfyg0002'),
			�ֻ�����=dbo.EncryptByPassPhrasePwd(�ֻ�����,'dfyg0003'),					
			�Ƿ��ѻ�,
			�������ڵ�,
			���ʷ�����ʽ,
			��λ����,
			��λ�绰=dbo.EncryptByPassPhrasePwd(��λ�绰,'dfyg0004'),
			�ͻ�ְҵ,
			��������,
			������ע,
			����ԭ��,
			������ԭ��,
			����ʱ��,
			���б�����Դ,
			���ձ�ע,
			����˵��,
			���ս���,
			��������,
			��������,
			�������,
			[�ʼ����.1],
			�����Ա,
			�������,
			�ͻ�����,
			��ע,
			�Ƿ���թ����,

			-----------------------------------��ɫ�ֶ�---------------------------------------------------
			--����
			[������Ա_G]=(select   top 1 ������   from ҵ��������� where �������=a.������� and  ����='���'  order by ��ʼʱ�� desc  ),
			[������Ա����_G]=(select  top 1  Ա����� from ҵ��������� where �������=a.������� and  ����='���' order by ��ʼʱ�� desc   ),
			[����ʼʱ��_G]=(select  top 1 ��ʼʱ�� from ҵ��������� where �������=a.������� and  ����='���'  order by ��ʼʱ�� desc  ),
			[�������ʱ��_G]=(select  top 1 ����ʱ�� from ҵ��������� where �������=a.������� and  ����='���'  order by ��ʼʱ�� desc  ),
			--����	
			[������Ա_G]=(select  top 1 ������ from ҵ��������� where �������=a.������� and  ����='����' order by ��ʼʱ�� desc   ),
			[������Ա����_G]=(select  top 1 Ա����� from ҵ��������� where �������=a.������� and  ����='����' order by ��ʼʱ�� desc  ),
			[����ʼʱ��_G]=(select  top 1 ��ʼʱ�� from ҵ��������� where �������=a.������� and  ����='����' order by ��ʼʱ�� desc  ),
			[�������ʱ��_G]=(select  top 1 ����ʱ�� from ҵ��������� where �������=a.������� and  ����='����' order by ��ʼʱ�� desc  ),--���鲻���������
			--����թ
			[����թ��Ա_G]=(select  top 1 ������ from ҵ��������� where �������=a.������� and  ���� like '%����թ%' order by ��ʼʱ�� desc   ),
			[����թ��Ա����_G]=(select  top 1 Ա����� from ҵ��������� where �������=a.������� and  ���� like '%����թ%' order by ��ʼʱ�� desc   ),----���
			[����թ��ʼʱ��_G]=(select  top 1 ��ʼʱ�� from ҵ��������� where �������=a.������� and  ���� like '%����թ%' order by ��ʼʱ�� desc  ),
			[����թ���ʱ��_G]=(select  top 1 ����ʱ�� from ҵ��������� where �������=a.������� and  ���� like '%����թ%' order by ��ʼʱ�� desc  ),
			--�ʼ�
			[�ʼ���Ա_G]=(select  top 1 ������ from ҵ��������� where �������=a.������� and  ���� like '%�ʼ�%'  order by ��ʼʱ�� desc  ),
			[�ʼ쿪ʼʱ��_G]=(select  top 1 ��ʼʱ�� from ҵ��������� where �������=a.������� and  ���� like '%�ʼ�%' order by ��ʼʱ�� desc  ),
			[�ʼ����ʱ��_G]=(select  top 1 ����ʱ�� from ҵ��������� where �������=a.������� and  ���� like '%�ʼ�%'  order by ��ʼʱ�� desc  ),
			ENTRYTIME
			into #temp
			from    ������Ϣ  a   WITH (NOLOCK)
				where ENTRYTIME>@MAXENTRYTIME ;




			insert into [dbo].[��������Դ_�ձ�]
			select �ŵ�,�������,����״̬,�Ƿ�Ӽ�,�ͷ�,������,�������,�����Ʒ,��������,������Ʒ,����ʱ��,������Ա,������,����ʱ��,������,�ܾ�ԭ�����,�ܾ�����ԭ�����,�ܾ�������ԭ�����,����ע,������Ա,������,����ʱ��,������,�ܾ�ԭ������,�ܾ�����ԭ������,�ܾ�������ԭ������,����ע,����թ��Ա,����թʱ��,����թ���,�ܾ�ԭ����թ,�ܾ���ԭ����թ,����թ��ע,�ʼ���Ա,�ʼ����,�ʼ쿪ʼʱ��,�ʼ����ʱ��,�ͻ�����,���֤����,�ֻ�����,�Ƿ��ѻ�,�������ڵ�,���ʷ�����ʽ,��λ����,��λ�绰,�ͻ�ְҵ,��������,������ע,����ԭ��,������ԭ��,����ʱ��,���б�����Դ,���ձ�ע,����˵��,���ս���,��������,��������,�������,[�ʼ����.1],�����Ա,�������,�ͻ�����,��ע,�Ƿ���թ����,[������Ա_G],[������Ա����_G],[����ʼʱ��_G],[�������ʱ��_G],	[������Ա_G],[������Ա����_G],[����ʼʱ��_G],[�������ʱ��_G],[����թ��Ա_G],[����թ��Ա����_G], [����թ��ʼʱ��_G],[����թ���ʱ��_G],[�ʼ���Ա_G],[�ʼ쿪ʼʱ��_G],[�ʼ����ʱ��_G]
			,
			-----------------------------------����Ϊ��ϴ�ֶ�---------------------------------------------------
			[��������]=convert(varchar(10),����ʱ��,120),
			[����ʱ��_R]=convert(varchar(10),����ʱ��,108),
			[�����������]=convert(varchar(10),[�������ʱ��_G],120),
			[�����������]=convert(varchar(10),[�������ʱ��_G],120),
			[����թ�������]=convert(varchar(10),[����թ���ʱ��_G],120),
			[��ϴ-��������]=case when ����״̬='�����-�����' and [����ʼʱ��_G] is null  then '��������'
								 when ����״̬='�����-�����' and [����ʼʱ��_G] is not null  then '��������'
								 when ����״̬='��˽���-ͬ��'  then '����'
								 when ����״̬ in ('��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�')  then '�ܾ�'
								 when ����״̬='�����-����'  then '������'
								 when ����״̬='�ʼ�ͨ��'  then 'δ����'
								 when ����״̬='�����-����թ���'  then '����թ������'	end,
			[�����������]=case when ����״̬ in ('��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�','��˽���-ͬ��') then (select (select Max(NewDate) from (values (convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[����թ���ʱ��_G],120))) as #temp(NewDate))  as time from ������Ϣ where  ������� =aa.�������) 	end,
			[������Ʒ_R]=isnull(������Ʒ,�����Ʒ),	
			[������Ȼ��ʱЧ]=case when [�������ʱ��_G] is not null then datediff(mi,����ʱ��,[�������ʱ��_G]) end ,
			[������Ȼ��ʱЧ]=case when [����թ���ʱ��_G]>[�������ʱ��_G] then 0
									   when [�������ʱ��_G] is not null then datediff(mi,[�������ʱ��_G],[�������ʱ��_G]) end, -----������
			[��������ʱЧ]=case	when convert(varchar(10),[�������ʱ��_G],120) is null then 0 
									   when convert(varchar(10),[�������ʱ��_G],120) is not null 
									   then 
											datediff(mi,����ʱ��,[�������ʱ��_G])-
											(
											 (select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ���� > convert(varchar(10),����ʱ��,120) and  ����< convert(varchar(10),[�������ʱ��_G],120) )
											  -
											 (select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ���� > convert(varchar(10),����ʱ��,120) and  ����< convert(varchar(10),[�������ʱ��_G],120) )
											)*60*24		end,
			[��������ʱЧ]=case when [����թ���ʱ��_G]>[�������ʱ��_G] then 0
									when convert(varchar(10),[�������ʱ��_G],120) is null then 0 
									   when convert(varchar(10),[�������ʱ��_G],120) is not null 
									   then 
											datediff(mi,[�������ʱ��_G],[�������ʱ��_G])-
											(
											 (select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����> convert(varchar(10),[�������ʱ��_G],120) and ����< convert(varchar(10),[�������ʱ��_G],120) )
											  -
											 (select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����> convert(varchar(10),[�������ʱ��_G],120) and ����< convert(varchar(10),[�������ʱ��_G],120) )
											)*60*24		 end,
			[���������Ȼ��ʱЧ]=case when ����״̬ in ('��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�','��˽���-ͬ��') 
											then datediff(mi,����ʱ��,(select (select Max(NewDate) from (values ([�������ʱ��_G]),([�������ʱ��_G]),([����թ���ʱ��_G])) as #temp(NewDate))  as time from ������Ϣ where  ������� =aa.�������) )
									else 0	end,
			[������ɹ�����ʱЧ]=case when ����״̬ in ('��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�','��˽���-ͬ��') 
											then 
												datediff(mi,����ʱ��,(select (select Max(NewDate) from (values ([�������ʱ��_G]),([�������ʱ��_G]),([����թ���ʱ��_G])) as #temp(NewDate))  as time from ������Ϣ where  ������� =aa.�������) )-
												(
												 (select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����>  convert(varchar(10),����ʱ��,120) and ����<(select (select Max(NewDate) from (values (convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[����թ���ʱ��_G],120))) as #temp(NewDate))  as time from ������Ϣ where  ������� =aa.�������) )
												  -
												 (select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����> convert(varchar(10),����ʱ��,120) and  ����<(select (select Max(NewDate) from (values (convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[�������ʱ��_G],120)),(convert(varchar(10),[����թ���ʱ��_G],120))) as #temp(NewDate))  as time from ������Ϣ where  ������� =aa.�������)  )
												)*60*24										
											else 0  end,
			[ȫ���Ƿ񲹼�]=case when �������� is not null then  '��'else '��' end ,

			[�޳����Ƿ񲹼�]=case when �������� is not null and (������ԭ�� like '%�����б���%' or ������ԭ�� like '%�貹��ʵ�����ż�ʵ���߷ñ�%' or ������ԭ�� like '%����ǰ��%') then '��'
								  when �������� is not null  then '��' 
							  else 'FALSE'  
							  end ,

			[����ʱ��_R]= case when ����ʱ�� is not null then  convert(varchar(10),����ʱ��,120)  end,
			[�Ƿ�ȫ��]= case when ����״̬ in ('��˽���-ͬ��','��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�') then '��'	else '��' end,
			[�ջ�����]=(select �ջ�����  from [�ջ������ŵ���ܱ�] where �ŵ�=aa.�ŵ�),
			[������]=(select ������  from [�ջ������ŵ���ܱ�] where �ŵ�=aa.�ŵ�),
			[����]=(select ����  from [�ջ������ŵ���ܱ�] where �ŵ�=aa.�ŵ�),
			[��Ͻ����]=(select ��Ͻ����  from [�ջ������ŵ���ܱ�] where �ŵ�=aa.�ŵ�),
			[�������]=case when ������� is not  null then  �������/10000 end ,
			[��ʱСʱ��_DAY]= cast(round(
					datediff(mi,����ʱ��,(select dbo.[last_work_day](convert(varchar(10),getdate(),120))))/60.0     
			  -
				(
					(select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����>  convert(varchar(10),����ʱ��,120) and  ����< convert(varchar(10),GETDATE(),120) )
					-
					(select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����>convert(varchar(10),����ʱ��,120) and   ����< convert(varchar(10),GETDATE(),120) )
				)*24,4) 
				as numeric(12,4)
				),

			[��ʱСʱ��_HOUR]= cast(round(
								datediff(mi,����ʱ��,GETDATE())/60.0
						  -
							(
								(select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����>   convert(varchar(10),����ʱ��,120) and  ����< convert(varchar(10),GETDATE(),120) )
								-
								(select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����> convert(varchar(10),����ʱ��,120) and ����< convert(varchar(10),GETDATE(),120) )
							)*24,4) 
							as numeric(12,4)
							)	,
			[�ж��Ƿ�ʱ_DAY]=case when (
										cast(round(
												datediff(mi,����ʱ��,(select dbo.[last_work_day](convert(varchar(10),getdate(),120))))/60.0     
											-
											(
												(select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����>  convert(varchar(10),����ʱ��,120) and ����<  convert(varchar(10),GETDATE(),120) )
												-
												(select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����>  convert(varchar(10),����ʱ��,120) and ����< convert(varchar(10),GETDATE(),120) )
											)*24,4) 
											as numeric(12,4)
											) > 48  
									)	
									and  
									����״̬ not in ('��˽���-ͬ��','��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�')
								then '��' 
								else '��' end ,
			[�ж��Ƿ�ʱ_HOUR]=case when (
											cast(round(
													datediff(mi,����ʱ��,GETDATE())/60
											  -
												(
													(select count(distinct ����)  from ��ȹ������ű� where ��� in ('˫����','�����շż�����') and ����>  convert(varchar(10),����ʱ��,120) and  ����< convert(varchar(10),GETDATE(),120) )
													-
													(select count(1) from ��ȹ������ű� where ���='��ĩ�ϰ�����' and ����>  convert(varchar(10),����ʱ��,120) and ����< convert(varchar(10),GETDATE(),120) )
												)*24,4) 
												as numeric(12,4)
												) > 48  
									)	
									and  
									����״̬ not in ('��˽���-ͬ��','��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�')
									then '��' 
									else '��' end ,
			[�Ƿ�δ����(AB)]=case when [�������ʱ��_G] is null then '��' else '��' end,
			[�Ƿ�δ����(AE)]=case when [�������ʱ��_G] is null and [����թ���ʱ��_G] is null then '��'  else '��' end,
			[�Ƿ���������(AA)]=case when [����ʼʱ��_G] is null then '��' else '��' end,
			[�Ƿ���������(AD)]=case when [����ʼʱ��_G] is null then '��' else '��' end, 
			[�Ƿ��ύ����թ(AG)]=case when  [����թ���ʱ��_G]  is null then '��' else '��' end,
			--[�Ƿ��ѹ]=case when ����״̬ in ('��˽���-ͬ��','��˽���-��˾ܾ�','����թ�ܾ�','��˽���-����ܾ�','��ؾ��߾ܾ�') then '��' else '��' end,
			[�Ƿ��ѹ]=case when ����״̬ in ('�����-����թ���','�����-�����','�ʼ�ͨ��') then '��' else '��' end,
			[������ְ��Ա����]=(select ���� from [������ϸ] where ����=aa.[������Ա����_G]),
			[������ְ��Ա����]=(select ���� from [������ϸ] where ����=aa.[������Ա����_G]),
			[����թ��ְ��Ա����]=(select ���� from [������ϸ] where ����=aa.[����թ��Ա����_G]),
			[����ͳһ]=case when ����״̬='����թ�ܾ�' then  (select ���� from [������ϸ] where ����=aa.[����թ��Ա����_G])
							else (select ���� from [������ϸ] where ����=aa.[������Ա����_G]) end,
			[ENTRYTIME]=ENTRYTIME
			from    #temp  aa ;

			print '�ձ�����---->�������'

			drop table #temp;

			exec('Data_Clean  ��������Դ_�ձ�,�������');

		END








END




















GO


