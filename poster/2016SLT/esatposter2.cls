% (c) 2004 Dong Hoon Van Uytsel, K.U.Leuven (ESAT)
% based on work by
% (c) 2002 Klaas Gadeyne and Tine Lefebvre, K.U.Leuven (PMA)
% (c) 1998, 1999 O. Karch, S. O. Krumke, H.-C. Wirth
% (c) 1997 Gerline Kettl, Matthias Weiser (a0poster.cls)

% - 2006-09-07 fix spacing in itemize and enumerate environments
% - 2006-08-24 added support for hvmaths and mtpro2
% v0.3
% - integrated code of a0poster.cls and eliminated use of a0header.ps
% - pstcol not explicitly loaded anymore
% - added \textboxbodyfont and \textboxtitlefont facility
% v0.2a
% - added commands \extleftlogo and \extrightlogo
% - cosmetic changes to \rtextbox and \textbox using \myshadowbox
% - added \rtextboxs and \textboxs which stretches instead of centers
%   its contents
% - default boxmargin changed from 2ex to 4ex
% - default page size set to a0 instead of a0b
% - poster contents now centered through proper \hoffset and \voffset
% - logo size influenced by \scaledimensions unlike previously
% - \extleftlogo and \extrightlogo robust
% v0.2
% - gradient added to default title box
% - added optional option to \maketitle (keyvals to \psframebox)
% - use parbox for \rframe instead of minipage
% v0.1
% - first version

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{esatposter2}[2006/09/07 v0.3a]

\LoadClass{article}

\newif\ifportrait
\newif\ifanullb
\newif\ifanull
\newif\ifaeins
\newif\ifazwei
\newif\ifadrei
\newif\ifdraft
\newif\ifsans
\newif\ifserif

\newcount\xkoord
\newcount\ykoord
\newcount\xscale
\newcount\yscale

\DeclareOption{a0b}{
\anullbtrue
\xkoord=2594 % big points (1 bp=1/72 inch)
\ykoord=3370 % big points (1 bp=1/72 inch)
\xscale=2
\yscale=2
}
\DeclareOption{a0}{
\anulltrue\anullbfalse
\xkoord=2380 % big points (1 bp=1/72 inch)
\ykoord=3368 % big points (1 bp=1/72 inch)
\xscale=2
\yscale=2
}
\DeclareOption{a1}{
\aeinstrue\anullbfalse
\xkoord=1684 % big points (1 bp=1/72 inch)
\ykoord=2380 % big points (1 bp=1/72 inch)
\xscale=3
\yscale=3
}
\DeclareOption{a2}{
\azweitrue\anullbfalse
\xkoord=1190 % big points (1 bp=1/72 inch)
\ykoord=1684 % big points (1 bp=1/72 inch)
\xscale=4
\yscale=4

}
\DeclareOption{a3}{
\adreitrue\anullbfalse
\xkoord=842  % big points (1 bp=1/72 inch)
\ykoord=1190 % big points (1 bp=1/72 inch)
\xscale=6
\yscale=6
}
\DeclareOption{landscape}{
\portraitfalse
}
\DeclareOption{portrait}{
\portraittrue
}
\DeclareOption{draft}{
\drafttrue
}
\DeclareOption{final}{
\draftfalse
}
\DeclareOption{serif}{
  \sansfalse
}
\DeclareOption{sans}{
  \sanstrue
}
\DeclareOption{helv}{
  \sanstrue
}

% Options: dvips, xdvi
\DeclareOption{dvips}{%
  \PassOptionsToPackage{dvips}{color}}
\DeclareOption{xdvi}{%
  \PassOptionsToPackage{xdvi}{color}}
\DeclareOption{dvipsnames}{%
  \PassOptionsToPackage{dvipsnames}{color}}
\DeclareOption{usenames}{%
  \PassOptionsToPackage{usenames}{color}}
\DeclareOption*{\PackageWarning{esatposter2}{Unknown Option \CurrentOption}}
\ExecuteOptions{a0,dvips,usenames,dvipsnames,final,landscape,serif}
\ProcessOptions

\RequirePackage{ifthen}
\RequirePackage{calc}
\RequirePackage[T1]{fontenc}
\RequirePackage{textcomp}
\ifsans
  \IfFileExists{t1hvr.fd} % hvmath fonts installed?
     {%\RequirePackage{mathptmx}
      \RequirePackage[scaled]{hvmaths}}
     {\RequirePackage[scaled]{helvet}}
  \renewcommand{\familydefault}{\sfdefault}
\else
  \IfFileExists{t1pfu.fd} % futura fonts installed?
    {\RequirePackage{futura}}
    {\RequirePackage[scaled=.92]{helvet}}
  \IfFileExists{umt2mf.fd} % mtpro2 fonts installed?
    {\RequirePackage{times}\RequirePackage[slantedGreek,mtpcal,subscriptcorrection]{mtpro2}}
    {\RequirePackage{mathptmx}}
\fi
\RequirePackage{pstricks}
\RequirePackage{pst-grad}
\RequirePackage{fancybox} % Shadow boxes
\RequirePackage{graphicx}

\ifanullb
   \setlength{\paperwidth}{119cm}
   \setlength{\paperheight}{87cm}
   \setlength{\textwidth}{114cm}
   \setlength{\textheight}{82cm}
\else\ifanull
        \setlength{\paperwidth}{1189mm}
        \setlength{\paperheight}{841mm}
        \setlength{\textwidth}{1149mm}
        \setlength{\textheight}{801mm}
     \else\ifaeins
             \setlength{\paperwidth}{841mm}
             \setlength{\paperheight}{594mm}
             \setlength{\textwidth}{801mm}
             \setlength{\textheight}{594mm}
          \else\ifazwei
                  \setlength{\paperwidth}{594mm}
                  \setlength{\paperheight}{420mm}
                  \setlength{\textwidth}{554mm}
                  \setlength{\textheight}{380mm}
               \else\ifadrei
                       \setlength{\paperwidth}{420mm}
                       \setlength{\paperheight}{297mm}
                       \setlength{\textwidth}{380mm}
                       \setlength{\textheight}{257mm}
                    \else\relax
                    \fi
               \fi
          \fi
     \fi
\fi


\ifportrait
   \newdimen\tausch
   \setlength{\tausch}{\paperwidth}
   \setlength{\paperwidth}{\paperheight}
   \setlength{\paperheight}{\tausch}
   \setlength{\tausch}{\textwidth}
   \setlength{\textwidth}{\textheight}
   \setlength{\textheight}{\tausch}
\fi

%% local variables
\newlength{\obj@height}
\newlength{\obj@width}


%% Setting proper dimensions for a DIN A0 printer

\setlength{\headheight}{0cm}
\setlength{\headsep}{0cm}
\setlength{\topmargin}{0cm}
\setlength{\oddsidemargin}{0cm}

\ifdraft
  \special{!userdict begin /start-hook{2 dict dup /PageSize [595 842]
  put dup /ImagingBBox null put setpagedevice 38 84 translate
  0.\number\xscale\space 0.\number\yscale\space scale}def end}
\else
  \special{!userdict begin /start-hook{2 dict dup /PageSize
  [\number\xkoord\space \number\ykoord] put dup /ImagingBBox null put
  setpagedevice
  }def end}
\fi

\renewcommand{\tiny}{\fontsize{12}{14}\selectfont}
\renewcommand{\scriptsize}{\fontsize{14.4}{18}\selectfont}   
\renewcommand{\footnotesize}{\fontsize{17.28}{22}\selectfont}
\renewcommand{\small}{\fontsize{20.74}{25}\selectfont}
\renewcommand{\normalsize}{\fontsize{24.88}{30}\selectfont}
\renewcommand{\large}{\fontsize{29.86}{37}\selectfont}
\renewcommand{\Large}{\fontsize{35.83}{45}\selectfont}
\renewcommand{\LARGE}{\fontsize{43}{54}\selectfont}
\renewcommand{\huge}{\fontsize{51.6}{64}\selectfont}
\renewcommand{\Huge}{\fontsize{61.92}{77}\selectfont}
\newcommand{\veryHuge}{\fontsize{74.3}{93}\selectfont}
\newcommand{\VeryHuge}{\fontsize{89.16}{112}\selectfont}
\newcommand{\VERYHuge}{\fontsize{107}{134}\selectfont}

\setlength\smallskipamount{6pt plus 2pt minus 2pt}
\setlength\medskipamount{12pt plus 4pt minus 4pt}
\setlength\bigskipamount{24pt plus 8pt minus 8pt}

\setlength\abovecaptionskip{25pt}
\setlength\belowcaptionskip{0pt}
\setlength\abovedisplayskip{25pt plus 6pt minus 15 pt}
\setlength\abovedisplayshortskip{0pt plus 6pt}
\setlength\belowdisplayshortskip{13pt plus 7pt minus 6pt}
\setlength\belowdisplayskip\abovedisplayskip

\normalsize

%% remark: dvips' configuration files must define a0, a1 and a2.
%Example:
% @ a0 841mm 1189mm
% @+ ! %%DocumentPaperSizes: a0
% @+ %%BeginPaperSize: a0
% @+ a0
% @+ %%EndPaperSize
%
% See /freeware/texmf/installed/texmf{.local,}/dvips/config/config.ps*

\AtBeginDocument{
\ifanullb
   \ifportrait\special{papersize=9151mm,1200mm}\else\special{papersize=1200mm,9151mm}\fi
\else\ifanull
       \ifportrait\special{papersize=841mm,1189mm}\else\special{papersize=1189mm,841mm}\fi
     \else\ifaeins
             \ifportrait\special{papersize=594mm,841mm}\else\special{papersize=841mm,594mm}\fi
          \else\ifazwei
                  \ifportrait\special{papersize=420mm,594mm}\else\special{papersize=594mm,420mm}\fi
               \else\ifadrei
                       \ifportrait\special{papersize=297mm,420mm}\else\special{papersize=420mm,297mm}\fi
                    \else\relax
                    \fi
               \fi
          \fi
     \fi
\fi
\pagestyle{empty}}

\shadowsize 0pt		% default shadow width for box frames
\def\boxframearc{1ex}	% default rounding for box frames
\parindent 0pt		% avoid problems with sloppy formatting
\parskip 0pt		% ...
\newlength\boxmargin
\boxmargin 4ex		% distance between border of box and its contents
\newlength\boxsep
\boxsep 4ex		% separation between boxes
\newlength\borderwidth
\borderwidth .2ex	% width of box borders
\newskip\innerwidth	% width of current box contents
\newskip\innerheight	% height of current box contents
\newlength{\bodywidth}	% width of poster body
\setlength{\bodywidth}{\textwidth}
\newlength{\bodyheight}	% height of poster body
\setlength{\bodyheight}{\textheight}
\newlength{\logowidth}  % width of logo's'
\setlength{\logowidth}{.04\textwidth}

% Color definitions
\definecolor{light-gray}{gray}{0.79}
\definecolor{dark-gray}{gray}{0.1}
\definecolor{orange}{rgb}{1, 0.647, 0}
\definecolor{darkorange}{rgb}{1, 0.549, 0}
\definecolor{lightorange}{rgb}{1, 0.902, 0.573}
\definecolor{kulblue}{rgb}{0 , 0.338, 0.765} % From KUL site
\definecolor{kulbluelight}{rgb}{0.60, 0.67, 0.75} % kulblue, less saturation
% Standard bgcolor
\definecolor{bgcolor}{rgb}{0.60, 0.67, 0.75} % kulblue, less saturation
%\definecolor{bgcolor}{rgb}{0.4039, 0.4039, 0.8039}

% scaledimensions
\newlength{\def@tinysize}    \setlength{\def@tinysize}{12pt}
\newlength{\def@scriptsize}  \setlength{\def@scriptsize}{14.4pt}
\newlength{\def@footnotesize}\setlength{\def@footnotesize}{17.28pt}
\newlength{\def@smallsize}   \setlength{\def@smallsize}{20.74pt}
\newlength{\def@normalsize}  \setlength{\def@normalsize}{24.88pt}
\newlength{\def@largesize}   \setlength{\def@largesize}{29.86pt}
\newlength{\def@Largesize}   \setlength{\def@Largesize}{35.83pt}
\newlength{\def@LARGEsize}   \setlength{\def@LARGEsize}{43pt}
\newlength{\def@hugesize}    \setlength{\def@hugesize}{51.6pt}
\newlength{\def@Hugesize}    \setlength{\def@Hugesize}{61.92pt}
\newlength{\def@veryHugesize}\setlength{\def@veryHugesize}{74.3pt}
\newlength{\def@VeryHugesize}\setlength{\def@VeryHugesize}{89.16pt}
\newlength{\def@VERYHugesize}\setlength{\def@VERYHugesize}{107pt}
\newlength{\def@tinyskip}    \setlength{\def@tinyskip}{140pt}
\newlength{\def@scriptskip}  \setlength{\def@scriptskip}{18pt}
\newlength{\def@footnoteskip}\setlength{\def@footnoteskip}{22pt}
\newlength{\def@smallskip}   \setlength{\def@smallskip}{25pt}
\newlength{\def@normalskip}  \setlength{\def@normalskip}{30pt}
\newlength{\def@largeskip}   \setlength{\def@largeskip}{37pt}
\newlength{\def@Largeskip}   \setlength{\def@Largeskip}{45pt}
\newlength{\def@LARGEskip}   \setlength{\def@LARGEskip}{54pt}
\newlength{\def@hugeskip}    \setlength{\def@hugeskip}{64pt}
\newlength{\def@Hugeskip}    \setlength{\def@Hugeskip}{77pt}
\newlength{\def@veryHugeskip}\setlength{\def@veryHugeskip}{93pt}
\newlength{\def@VeryHugeskip}\setlength{\def@VeryHugeskip}{112pt}
\newlength{\def@VERYHugeskip}\setlength{\def@VERYHugeskip}{134pt}
\newcommand{\scaledimensions}[1]{%
  \renewcommand{\tiny}{#1\fontsize{\def@tinysize}{#1\def@tinyskip}\selectfont}%
  \renewcommand{\scriptsize}{\fontsize{#1\def@scriptsize}{#1\def@scriptskip}\selectfont}%
  \renewcommand{\footnotesize}{\fontsize{#1\def@footnotesize}{#1\def@footnoteskip}\selectfont}%
  \renewcommand{\small}{\fontsize{#1\def@smallsize}{#1\def@smallskip}\selectfont}%
  \renewcommand{\normalsize}{\fontsize{#1\def@normalsize}{#1\def@normalskip}\selectfont}%
  \renewcommand{\large}{\fontsize{#1\def@largesize}{#1\def@largeskip}\selectfont}%
  \renewcommand{\Large}{\fontsize{#1\def@Largesize}{#1\def@Largeskip}\selectfont}%
  \renewcommand{\LARGE}{\fontsize{#1\def@LARGEsize}{#1\def@LARGEskip}\selectfont}%
  \renewcommand{\huge}{\fontsize{#1\def@hugesize}{#1\def@hugeskip}\selectfont}%
  \renewcommand{\Huge}{\fontsize{#1\def@Hugesize}{#1\def@Hugeskip}\selectfont}%
  \renewcommand{\veryHuge}{\fontsize{#1\def@veryHugesize}{#1\def@veryHugeskip}\selectfont}%
  \renewcommand{\VeryHuge}{\fontsize{#1\def@VeryHugesize}{#1\def@VeryHugeskip}\selectfont}%
  \renewcommand{\VERYHuge}{\fontsize{#1\def@VERYHugesize}{#1\def@VERYHugeskip}\selectfont}%
  \setlength{\borderwidth}{#1\borderwidth}%
  \setlength{\boxsep}{#1\boxsep}%
  \setlength{\boxmargin}{#1\boxmargin}%
  \setlength{\logowidth}{#1\logowidth}%
}
\scaledimensions{1}

% allow all sizes of cmtt
\DeclareFontShape{OT1}{cmtt}{m}{n}{ <5-8> cmtt8 <9> cmtt9 <10-10.99> cmtt10 <12-> cmtt12 }{}
\DeclareFontShape{OT1}{cmtt}{m}{it}{ <-> cmitt10 }{}
\DeclareFontShape{OT1}{cmtt}{m}{sl}{ <-> cmsltt10 }{}
\DeclareFontShape{OT1}{cmtt}{m}{sc}{ <-> cmtcsc10 }{}


% default styles
\newpsobject{myshadowbox}{psshadowbox}{linecolor=kulblue,linewidth=\borderwidth,shadow=true,shadowsize=\shadowsize,cornersize=absolute,linearc=\boxframearc,framesep=\boxmargin,fillcolor=white,fillstyle=solid}
\newcommand{\def@textboxtitlefont}{\large\sffamily\color{white}}
\newcommand{\def@textboxbodyfont}{\color{black}}
\newcommand{\textboxtitlefont}{}
\newcommand{\textboxbodyfont}{}

%%% \expertbox{ Options }{ width }{ Box-Text } 
%%% \expertshadowbox{ Options }{ width }{ Box-Text } 

\long\def\expertbox#1#2#3{%
  \psframebox[linecolor=kulblue,linewidth=\borderwidth,#1]{%
    \setlength{\innerwidth}{#2-2\boxmargin-2\borderwidth}%
    \rule{0pt}{\innerheight}\begin{minipage}{\innerwidth}#3\end{minipage}}}

\long\def\expertshadowbox#1#2#3{%
  \psframebox[linecolor=kulblue,linewidth=\borderwidth,shadow=true,%
    shadowsize=\shadowsize,framesep=\boxmargin,#1]{%
    \setlength{\innerwidth}{#2-2\boxmargin-2\borderwidth}%
    \rule{0pt}{\innerheight}\begin{minipage}{\innerwidth}#3\end{minipage}}}

% \underbase{ Box } and \overbase{ Box } shift the baseline of a box
% such that the complete box is placed under c.q. above the baseline.
\long\def\underbase#1{\raisebox{-\height}[0pt][\totalheight]{#1}}
\long\def\overbase#1{\raisebox{\depth}[\totalheight][0pt]{#1}}

% \textbox[boxdecoration]{width}{height}{caption}{contents}
\newcommand{\textbox}[5][fillstyle=solid]{%
  \newsavebox{\caption@box}\savebox{\caption@box}{#4}%
  \newlength{\caption@width}\settowidth{\caption@width}{\usebox{\caption@box}}%
  \myshadowbox[#1]{%
      \ifthenelse{\lengthtest{\caption@width=0pt}}{}{%
        \rlap{\raisebox{\boxmargin}[0pt][0pt]{%
          \psframebox[linecolor=kulblue,framesep=.5ex,cornersize=absolute,linearc=\boxframearc,fillcolor=kulblue,%
	    fillstyle=solid,linewidth=0pt]{%
            \large\textsf{\textcolor{white}{\usebox{\caption@box}}}}}}%
      }%
      \setlength{\innerwidth}{#2-2\borderwidth-2\boxmargin}%
      \setlength{\innerheight}{#3-2\borderwidth-2\boxmargin}%
      \underbase{%
        \rule{0pt}{\innerheight}%
	\begin{minipage}[b][\innerheight][c]{\innerwidth}%
	  \rule{\innerwidth}{0pt}\\%
          \color{black}#5%
        \end{minipage}}}}
\newcommand{\textboxs}[5][fillstyle=solid]{%
  \myshadowbox[#1]{%
      \ifthenelse{\equal{#4}{}}{}{%
        \rlap{\raisebox{\boxmargin}[0pt][0pt]{%\hspace*{\boxmargin}%
          \psframebox[linecolor=kulblue,framesep=.5ex,cornersize=absolute,linearc=\boxframearc,fillcolor=kulblue,%
	    fillstyle=solid,linewidth=0pt]{%
            \large\textsf{\textcolor{white}{#4}}}}}%
      }%
      \setlength{\innerwidth}{#2-2\borderwidth-2\boxmargin}%
      \setlength{\innerheight}{#3-2\borderwidth-2\boxmargin}%
      \underbase{%
        \rule{0pt}{\innerheight}%
	\begin{minipage}[b][\innerheight][s]{\innerwidth}%
	  \rule{\innerwidth}{0pt}\\%
          \color{black}#5%
        \end{minipage}}}}

% \rtextbox[boxdecoration]{rwidth}{rheight}{caption}{contents}
% absolute widths and heights are computed as
% rwidth * ( bodywidth + boxsep ) - boxsep
% sum of rwidths + (n-1)*boxsep = bodywidth + boxsep - n*boxsep + (n-1)*boxsep = bodywidth
% This causes problems when boxsep < rwidth*bodywidth/(1-rwidth)
\newcommand{\rtextbox}[5][fillstyle=solid]{%
  \myshadowbox[#1]{%
      \ifthenelse{\equal{#4}{}}{}{%
        \rlap{\raisebox{\boxmargin}[0pt][0pt]{%\hspace*{\boxmargin}%
          \psframebox[linecolor=kulblue,framesep=.5ex,fillcolor=kulblue,%
	    fillstyle=solid,linewidth=0pt]{%
            {\def@textboxtitlefont\textboxtitlefont #4}}}}%
      }%
      \setlength{\innerwidth}{\bodywidth*\real{#2}+\boxsep*\real{#2}-\boxsep-2\borderwidth-2\boxmargin}%
      \setlength{\innerheight}{\bodyheight*\real{#3}+\boxsep*\real{#3}-\boxsep-2\borderwidth-2\boxmargin}%
      \underbase{%
        \rule{0pt}{\innerheight}%
	\begin{minipage}[b][\innerheight][c]{\innerwidth}%
	  \rule{\innerwidth}{0pt}\\%
	  \def@textboxbodyfont\textboxbodyfont #5%
        \end{minipage}}}}
\newcommand{\rtextboxs}[5][fillstyle=solid]{%
  \myshadowbox[#1]{%
      \ifthenelse{\equal{#4}{}}{}{%
        \rlap{\raisebox{\boxmargin}[0pt][0pt]{%\hspace*{\boxmargin}%
          \psframebox[linecolor=kulblue,framesep=.5ex,fillcolor=kulblue,%
	    fillstyle=solid,linewidth=0pt]{%
            {\def@textboxtitlefont\textboxtitlefont #4}}}}%
      }%
      \setlength{\innerwidth}{\bodywidth*\real{#2}+\boxsep*\real{#2}-\boxsep-2\borderwidth-2\boxmargin}%
      \setlength{\innerheight}{\bodyheight*\real{#3}+\boxsep*\real{#3}-\boxsep-2\borderwidth-2\boxmargin}%
      \underbase{%
        \rule{0pt}{\innerheight}%
	\begin{minipage}[b][\innerheight][s]{\innerwidth}%
	  \rule{\innerwidth}{0pt}\\%
          \def@textboxbodyfont\textboxbodyfont #5%
        \end{minipage}}}}

% \rframe{width}{height}{contents} : container of vertically stacked \textbox's '

% ??? with minipage, we are getting stack overflows. using parbox instead
\newcommand{\rframeMP}[3]{%
  \begin{minipage}[t][\bodyheight*\real{#2}+\boxsep*\real{#2}-\boxsep]{\bodywidth*\real{#1}+\boxsep*\real{#1}-\boxsep}#3\end{minipage}}

\newcommand{\rframe}[3]{%
  \setlength{\obj@height}{\bodyheight*\real{#2}+\boxsep*\real{#2}-\boxsep}%
  \setlength{\obj@width}{\bodywidth*\real{#1}+\boxsep*\real{#1}-\boxsep}%
  \ifthenelse{\lengthtest{\obj@height > 0pt}}{%
    \ifthenelse{\lengthtest{\obj@width > 0pt}}{%
      \parbox[t][\obj@height]{\obj@width}{#3}}%
      {\vspace{\obj@height}\hspace{\obj@width}}}%
    {\vspace{\obj@height}\hspace{\obj@width}}}
% \bghoffset und \bgvoffset bestimmen die Verschiebung des
% Hintergrundbildchens nach links und nach rechts, \backgroundwidth
% gibt die Breite des Hintergrundbildchens an, \bgpic{ } sorgt für die
% richtige Positionierung
\newskip\bghoffset
\newskip\bgvoffset
\newskip\backgroundwidth
\bghoffset1in
\bgvoffset1in
\setlength{\backgroundwidth}{\paperwidth-2\bghoffset}
\def\bgpic#1{\rlap{\vbox to 0pt {\raisebox{\bgvoffset}[0pt][0pt]{%
      \underbase{\llap{\makebox[\bghoffset][l]{#1}}}}}}}
\pagecolor{bgcolor} % Default backgroundcolor

% You can modify these
%\setlength{\bghoffset}{1in}
%\setlength{\bgvoffset}{1in}

% a0poster.cls defines textheight/textwidth 4cm less than
% paperheight/-width.
\setlength{\hoffset}{2cm-1in}
\setlength{\voffset}{2cm-1in}

\newcommand{\extraleftlogo}{}
\newcommand{\extrarightlogo}{}
\def\@affiliation{Katholieke Universiteit Leuven, Department of Electrical Engineering (ESAT)}
\def\@contact{Kasteelpark Arenberg 10, B--3001 Leuven-Heverlee, Belgium}
\newcommand{\affiliation}[1]{\renewcommand{\@affiliation}{#1}}
\newcommand{\contact}[1]{\renewcommand{\@contact}{#1}}
\newcommand{\extleftlogo}[1]{\renewcommand{\extraleftlogo}{#1}}
\newcommand{\extrightlogo}[1]{\renewcommand{\extrarightlogo}{#1}}

\newlength{\title@totalheight}
\renewcommand{\maketitle}[1][fillstyle=gradient]{%
  \newsavebox{\title@box}%
  \newsavebox{\extraleft@logo}%
  \newsavebox{\extraright@logo}%
  \newlength{\titlewidth}\newlength{\extraleftlogowidth}\newlength{\extrarightlogowidth}%
  \savebox{\extraleft@logo}{\hbs\extraleftlogo}%
  \savebox{\extraright@logo}{\extrarightlogo\hbs}%
  \settowidth{\extraleftlogowidth}{\usebox{\extraleft@logo}}%
  \settowidth{\extrarightlogowidth}{\usebox{\extraright@logo}}%
  \setlength{\titlewidth}{\textwidth-2\logowidth-\extraleftlogowidth-%
     \extrarightlogowidth-2\boxmargin-2\borderwidth}%
  \savebox{\title@box}{%
    \expertshadowbox{fillstyle=gradient,gradbegin=lightorange,gradend=white,gradangle=60,gradmidpoint=.2,cornersize=absolute,linearc=\boxframearc,framesep=\boxmargin,#1}{\textwidth}{%
      \parbox[c]{\logowidth}{\includegraphics[width=\logowidth]{sedes.eps}}%
      \parbox[c]{\extraleftlogowidth}{\usebox{\extraleft@logo}}%
      \parbox[c]{\titlewidth}{%
        \centering
          {\LARGE\textbf{\uppercase{\@title}}\\}
          {\Large\textbf{\textit{\@author}\\}}
	  {\large\@affiliation\\\@contact}}%
      \parbox[c]{\extrarightlogowidth}{\usebox{\extraright@logo}}%
      \parbox[c]{\logowidth}{\includegraphics[width=\logowidth]{esatlogo.eps}}\\%
    }}%
  \par\noindent\usebox{\title@box}\vspace{\boxsep}\par%
  \setlength{\title@totalheight}{\heightof{\usebox{\title@box}}+\depthof{\usebox{\title@box}}}
  \addtolength{\bodyheight}{-\title@totalheight-\boxsep-\parskip}%
}

%% convenience macro's: %'

% \hbs = horizontal box separator, \vbs = vertical box separator
\def\hbs{\hspace{\boxsep}}
\def\vbs{\vspace{\boxsep}\linebreak}

%% redefinition of itemize and enumerate environments

\renewcommand{\itemize}{%
  \ifnum \@itemdepth >\thr@@\@toodeep\else
    \advance\@itemdepth\@ne
    \edef\@itemitem{labelitem\romannumeral\the\@itemdepth}%
    \expandafter
    \list
      \csname\@itemitem\endcsname
      {\def\makelabel##1{##1\hss}%
        \leftmargin 1.5em
	\labelsep .5em
	\labelwidth 1em
      }%
  \fi}
\renewcommand{\enumerate}{%
  \ifnum \@enumdepth >\thr@@\@toodeep\else
    \advance\@enumdepth\@ne
    \edef\@enumctr{enum\romannumeral\the\@enumdepth}%
      \expandafter
      \list
        \csname label\@enumctr\endcsname
        {\usecounter\@enumctr\def\makelabel##1{##1\hss}%
           \leftmargin 1.5em
           \labelsep .5em
           \labelwidth 1em
        }%
  \fi}

\endinput
%% end of class esatposter.cls
