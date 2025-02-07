# 03/31/23
# tagfunction()

tagfunction <- function(page_title,page_subtitle,Genome_choice,chromosome_choice, default_choice,GeneID_example,default_ref){
      
      tagList(

           fluidPage(theme = shinytheme("readable")), ## cerulean, cosmo, cyborg, darkly, flatly, journal, lumen, paper, readable, sandstone, simplex, slate, spacelab, superhero, united, yeti
       #   fluidPage(shinythemes::themeSelector()),

     #   h1("This is WheatTest Page!",style="text-align:center"),
         h2(page_title,style="text-align:center"),
         nav_links,

# To add ui part for page6   

useShinyjs(),

column(8,offset = 5, titlePanel(page_subtitle)), # titlePanel

sidebarLayout(

sidebarPanel(

inputIp("ipid"),
textOutput("testtext"),

column(12,wellPanel(div(id='my_textinput1' ,
                   textInput("Gene",paste("Gene name ",'(such as ',GeneID_example,' for ',default_ref,')'," or YourID for fasta sequence",sep='') )))),
                   tags$style(type="text/css", "#my_textinput1 {color: red}","#my_textinput1 {font-size:14px;}"),


uiOutput("html"),


column(12, offset = 4 , actionButton("Check_ID", label = "(1) Check Gene ID",style = 'background-color:#FFCCCC; padding:20px; font-size:100%')),
bsTooltip("Check_ID", "Check your gene name in our database","right", options = NULL),

column(12,
pickerInput(
  inputId = "Pickgenome", 
  label = "Pick Genome (Please select one)", 
  choices = Genome_choice,
  selected = c(''), ## by default

  options = list(
    'actions-box' = TRUE, 
    size = 15,
    'selected-text-format' = "count > 1"
  ), 
  multiple = FALSE,
)
),


column(12,
pickerInput(
  inputId = "Chr", 
  label = "Chromosome (Please select one)", 
  choices = chromosome_choice,
  selected = c(''), ## by default
  options = list(
    'actions-box' = TRUE, 
    size = 15,
    'selected-text-format' = "count > 1"
  ), 
  multiple = FALSE,
)
),

column(12,
pickerInput(
  inputId = "Pickformat", 
  label = "CDS (Coding sequence) or your fasta sequence", 
  choices = c('CDS','fasta_seq'),
  selected = c('CDS'), ## by default
  options = list(
    'actions-box' = TRUE, 
    size = 15,
    'selected-text-format' = "count > 1"
  ), 
  multiple = FALSE,
)
),

column(12,textAreaInput("fasta","Your fasta sequence (Please add >YourID before pasting your DNA sequence)",height='100px')),
bsTooltip("fasta", ">YourID as the first line","right", options = NULL),

tags$script(checkjs1), #03/07/23
column(12,attrib_replace( fileInput("upload1", "Upload Parent1 (File name: Parent1_chr**.fa.gz)", multiple = FALSE),
       list(id = "upload1", type = "file"), onchange = "checkFileName1(this);") ),
  
tags$script(checkjs2), #03/07/23
column(12,attrib_replace( fileInput("upload2", "Upload Parent2 (File name: Parent2_chr**.fa.gz)", multiple = FALSE),
       list(id = "upload2", type = "file"), onchange = "checkFileName2(this);") ), 

#column(12,fileInput("upload1", "Upload Parent1 (Format: Parent1_chr**.fa.gz)", multiple = FALSE)), 
#column(12,fileInput("upload2", "Upload Parent2 (Format: Parent2_chr**.fa.gz)", multiple = FALSE)),

column(12,textInput("Upstream","Upstream (kb), the maximum size should be <=100 (kb)",value=0)),
column(12,textInput("Downstream","Downstream (kb), the maximum size should be <=100 (kb)",value=0)),

column(12,
pickerInput(
  inputId = "id", 
  label = "Genomes (Defalt: all genomes selected)", 
   choices = default_choice,
   selected = default_choice,
  options = list(
    'actions-box' = TRUE, 
    size = 15,
    'selected-text-format' = "count > 1"
  ), 
  multiple = TRUE,
)
),

column(12,sliderInput("Distancefilter", "Distance filter between mapped clusters (1kb - 50kb)", min = 1000, max = 50000, value =20000)),
column(12,sliderInput("CDSfilter", "Expected CDS size compared to Reference (fold change: 0.25 - 4)", min = 0.25, max = 4, value =c(0.75,1.25))),

column(12,actionButton("submit", label = "(2) Submit",class = "btn-warning")),
bsTooltip("submit", "Please double check your input (format), and then submit your job","right", options = NULL),


uiOutput("Largefile"),

uiOutput("clustertree"),

uiOutput("Haplotypes"),

uiOutput("bucket"),

uiOutput("submit_trim"),

uiOutput("plotSV_parameters"),

#uiOutput("PNG"),

uiOutput("extract_fa"),

downloadButton('Save',label = "Save .zip file to ...",style = "background-color:#FFFFFF"),

#uiOutput("Save"),

uiOutput("done"),

), # sidebarPanel


mainPanel(
fluidRow(
  
############### IP test
# tags$head(
#    tags$script(src="getIP.js")
#  ),
 verbatimTextOutput('IP'),       
############### IP test
 
 #    column(12,verbatimTextOutput("visits")), ## number of visits
 #    column(12,verbatimTextOutput("infogene")), ## number of jobs submitted

     #textOutput('coordinates_test'),
     column(12, offset=0, align="center", textOutput('coordinates_test') ), # 03/06/23 
     tags$head(tags$style("#coordinates_test{color: blue;
                                 font-size: 22px;
                                 font-style: arial;
                                 }"
                         )
     ),

     column(12, offset=0, align="center", textOutput('strand_notice') ), # 03/06/23 
     tags$head(tags$style("#strand_notice{color: red;
                                 font-size: 22px;
                                 font-style: arial;
                                 }"
                         )
     ),

     textOutput('fasta_test'),
     tags$head(tags$style("#fasta_test{color: red;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
                         )
     ),

     textOutput('upload1_name_test'),
     tags$head(tags$style("#upload1_name_test{color: red;
                                 font-size: 24px;
                                 font-style: italic;
                                 }"
                         )
     ),  #03/07/23

     textOutput('upload1_test'),
     tags$head(tags$style("#upload1_test{color: green;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
                         )
     ),

     textOutput('upload2_name_test'),
     tags$head(tags$style("#upload2_name_test{color: red;
                                 font-size: 24px;
                                 font-style: italic;
                                 }"
                         )
     ),  #03/07/23


     textOutput('upload2_test'),
     tags$head(tags$style("#upload2_test{color: green;
                                 font-size: 16px;
                                 font-style: italic;
                                 }"
                         )
     ),

    # textOutput('job_timer'),
    # tags$head(tags$style("#job_timer{color: orange;
    #                             font-size: 20px;
    #                             font-style: italic;
    #                             }"
    #                     )
    # ),

     textOutput('Up_down_stream_remainder'),
     tags$head(tags$style("#Up_down_stream_remainder{color: blue;
                                 font-size: 20px;
                                 font-style: italic;
                                 }"
                         )
     ),

#### progress in middle
tags$head(
    tags$style(
      HTML(".shiny-notification {
              height: 100px;
              width: 800px;
              position:fixed;
              top: calc(50% - 50px);;
              left: calc(50% - 400px);;
            }
           "
      )
    )
  ),
#### progress in middle

     column(12,offset=0, align="left", textOutput('Size_remainder') ), #6/14/23
     tags$head(tags$style("#Size_remainder{color: red;
                                 font-size: 24px;
                                 font-style: italic;
                                 }"
                         )
     ),




     column(7, offset=0,align="left", uiOutput(outputId = "Fig_demo") ),

    # column(8, plotOutput("Fig_demo",click = NULL,dblclick = NULL,width ="100%",height = 'auto') ),


     column(6, plotOutput("plot",click = NULL,dblclick = NULL,width = "100%",height = 'auto')),

     column(6, plotOutput("plot2",click = "plot2_click",dblclick = NULL,width = "100%",height = 'auto')),
     
     column(12,verbatimTextOutput("info2")),

     column(12,verbatimTextOutput("info4")),

     column(12,verbatimTextOutput("info3")),

     column(12,verbatimTextOutput("info_TE")),

     column(12, offset=0, align="center", textOutput('info') ),                     
     tags$head(tags$style("#info{color: blue;
                                 font-size: 24px;
                                 font-style: Arial;
                                 }"
                         )
     ), # 03/06/23

     column(12, plotOutput("plot3",click = "plot3_click",dblclick = "plot3_dblclick",hover = "plot3_hover",width = "100%",height = 'auto')),


     column(12,verbatimTextOutput("info_Trim0")), #03/07/23
     column(12,offset=0, align="center", textOutput("info_Trim")), #03/07/23
     tags$head(tags$style("#info_Trim{color: blue;
                                 font-size: 24px;
                                 font-style: Arial;
                                 }"
                         )
     ), #03/07/23

    #column(12,verbatimTextOutput("info_plotSV0")), #03/07/23
     column(12,offset=0, align="center", textOutput("info_plotSV")), #03/07/23
     tags$head(tags$style("#info_plotSV{color: black;
                                 font-size: 18px;
                                 font-style: Arial;
                                 }"
                         )
     ), #03/20/23
    


     column(12, offset=0,align="center", plotOutput("plot4",click = NULL,dblclick = NULL,width = "100%",height = 'auto')),

     column(12, offset = 0,DT::dataTableOutput("table4"),style='padding-top:5px; padding-bottom:5px'), # 2/9/23

     column(12, offset = 0,DT::dataTableOutput("table1"),style='padding-top:5px; padding-bottom:5px'), ## 06/17, cluster information
      
     column(12, offset = 0,DT::dataTableOutput("table2"),style='padding-top:5px; padding-bottom:5px'),

#     column(12, offset = 0,DT::dataTableOutput("table3"),style='padding-top:5px; padding-bottom:5px'),


# column(12, offset = 0,DT::dataTableOutput("table4"),style='padding-top:5px; padding-bottom:5px'),
# column(12, offset = 0,DT::dataTableOutput("tablecluster"),style='padding-top:5px; padding-bottom:5px')

)
) # mainPanel


) # sidebarLayout


      ) # For tagList

    } # function

#################################################################
#################################################################