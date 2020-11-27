CXXFLAGS += -DGAME_EXECUTABLE -D__STDC_CONSTANT_MACROS

BINDIR = bin

GAME_OBJFILES = src/Animation.o \
	src/AnimationSound.o \
	src/CaseContent/Area.o \
	src/CaseContent/Conversation.o \
	src/CaseContent/Crowd.o \
	src/CaseContent/Dialog.o \
	src/CaseContent/Encounter.o \
	src/CaseContent/FieldCharacter.o \
	src/CaseContent/FieldCutscene.o \
	src/CaseContent/Location.o \
	src/CaseContent/ForegroundElement.o \
	src/CaseContent/Notification.o \
	src/CaseContent/ZoomedView.o \
	src/CaseInformation/AnimationManager.o \
	src/CaseInformation/AudioManager.o \
	src/CaseInformation/Case.o \
	src/CaseInformation/CommonCaseResources.o \
	src/CaseInformation/ContentManager.o \
	src/CaseInformation/DialogCharacterManager.o \
	src/CaseInformation/DialogCutsceneManager.o \
	src/CaseInformation/EvidenceManager.o \
	src/CaseInformation/FieldCharacterManager.o \
	src/CaseInformation/FieldCutsceneManager.o \
	src/CaseInformation/FlagManager.o \
	src/CaseInformation/FontManager.o \
	src/CaseInformation/PartnerManager.o \
	src/CaseInformation/SpriteManager.o \
	src/Collisions.o \
	src/Color.o \
	src/Condition.o \
	src/EasingFunctions.o \
	src/FileFunctions.o \
	src/Game.o \
	src/HeightMap.o \
	src/Image.o \
	src/Interfaces.o \
	src/KeyboardHelper.o \
	src/Line.o \
	src/LocalizableContent.o \
	src/MLIException.o \
	src/MLIFont.o \
	src/MouseHelper.o \
	src/Polygon.o \
	src/Rectangle.o \
	src/ResourceLoader.o \
	src/Screens/CheckForUpdatesScreen.o \
	src/Screens/GameScreen.o \
	src/Screens/LanguageScreen.o \
	src/Screens/LogoScreen.o \
	src/Screens/OptionsScreen.o \
	src/Screens/SelectionScreen.o \
	src/Screens/TitleScreen.o \
	src/SharedUtils.o \
	src/Sprite.o \
	src/State.o \
	src/TextInputHelper.o \
	src/UserInterface/Arrow.o \
	src/UserInterface/ButtonArray.o \
	src/UserInterface/EvidenceDescription.o \
	src/UserInterface/EvidenceSelector.o \
	src/UserInterface/ImageButton.o \
	src/UserInterface/PartnerInformation.o \
	src/UserInterface/PromptOverlay.o \
	src/UserInterface/Selector.o \
	src/UserInterface/SkipArrow.o \
	src/UserInterface/Slider.o \
	src/UserInterface/Tab.o \
	src/UserInterface/TextButton.o \
	src/UserInterface/TextWidget.o \
	src/Utils.o \
	src/Vector2.o \
	src/Version.o \
	src/Video.o \
	src/XmlReader.o \
	src/XmlStorableObject.o \
	src/XmlWriter.o \
	src/enums.o \
	src/globals.o \
	src/main.o \
	src/miniz.o \
	src/mli_audio.o \
	src/tinyxml2/tinyxml2.o \
	src/Events/EventProviders.o

$(BINDIR)/mli: $(GAME_OBJFILES)
	mkdir -p $(BINDIR)
	$(CXX) -o $@ $^ -lSDL2 -lSDL2_mixer -lcryptopp -lSDL2_ttf -lSDL2_image -lavcodec -lswscale -lavdevice -lavfilter -lavformat -lavresample -lavutil

clean:
	rm -rf $(GAME_OBJFILES)
