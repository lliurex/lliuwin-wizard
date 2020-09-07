#!/usr/bin/python3
import getpass
import sys
import os
from PyQt5.QtWidgets import QApplication, QLabel, QWidget, QComboBox,QPushButton,QVBoxLayout,\
				QDialog,QStackedWidget,QGridLayout,QTabBar,QTabWidget,QHBoxLayout,QFormLayout,QLineEdit,QComboBox,\
				QStatusBar,QFileDialog,QDialogButtonBox,QScrollBar,QScrollArea,QCheckBox,QTableWidget,\
				QTableWidgetItem, QFrame,QHeaderView,QTableWidgetSelectionRange,QInputDialog,QDesktopWidget
from PyQt5 import QtGui
from PyQt5.QtCore import QSize,pyqtSlot,Qt, QPropertyAnimation,QThread,QRect,QTimer,pyqtSignal,QSignalMapper,QProcess,QEvent
from edupals.ui import QAnimatedStatusBar
import gettext
import subprocess
import signal
import psutil
import locale
import time
import tempfile
from urllib.request import urlretrieve
QString=type("")
QInt=type(0)
TAB_BTN_SIZE=96
BTN_SIZE=128
gettext.textdomain('wizard')
_ = gettext.gettext
CANCEL=_("Cancel")
ACCEPT=_("Accept")

class QImgDialog(QDialog):
	def __init__(self):
		super().__init__()
		self.dbg=True

	def _render(self):
		lay=QGridLayout()

