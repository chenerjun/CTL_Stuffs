import pandas as pd
import datetime
#import lxml
#import html5lib
#import beautifulSoup4
now = datetime.datetime.now()
#url = 'https://app.periscopedata.com/shared/2bf342ed-bf87-4795-b095-781281741c91'
#table= pd.read_html('https://app.periscopedata.com/shared/2bf342ed-bf87-4795-b095-781281741c91')
csvfnPath = "c:/temp/"
csv_FirstConversation = "FirstConversation_"+now.strftime("%Y-%m-%d")+".csv"
csv_CRLeveledup = "CR_Leveled_"+now.strftime("%Y-%m-%d")+".csv"
csvfn = csvfnPath+"GeneralSigtables.csv"
gs = pd.read_csv(csvfn)
col = ['name','email','date_trunc', 'conversation_id']
cr = gs[col]


def firstConv(df):
    fc = df.sort_values('date_trunc').groupby('name').first()
    #fc['name'] = fc.index
    return fc




def leveledup(df):
    gbdf = df.groupby('name')
    lc = pd.DataFrame()
    lc['name'] = gbdf.size().index
    lc['num'] = gbdf.size().tolist()

    #get email
    le=pd.merge(lc,df, left_on='name', right_on='name', how = 'inner') [['name','email']]
    le = le.drop_duplicates()
    # merge email onto lc
    lc = pd.merge(lc,le, left_on='name', right_on='name', how = 'inner')
    lc['level'] = 0
    #leveled up
    i=0
    while i < len(lc):
        x=lc.loc[i,'num']
        if x<10:
            level=1
        elif 10<=x and x<19:
            level=2
        elif 20<=x and x<49:
            level=3
        elif 50<=x and x<99:
            level=4
        elif 100<=x and x<249:
            level=5
        elif 250<=x and x<499:
            level=6
        elif 500<=x and x<999:
            level=7
        else:
            level=8
        lc.iloc[i,3] = level
        i=i+1

    return lc

# process first conversation
df_1stConv = firstConv(cr)
df_1stConv = df_1stConv.rename(columns={'date_trunc':'First_Conversation_Date'})
df_1stConv[['email','First_Conversation_Date']].to_csv(csvfnPath + csv_FirstConversation)

# process leveled up
df_CrLeveled = leveledup(cr)

# export to csv
df_CrLeveled .to_csv(csvfnPath + csv_CRLeveledup)